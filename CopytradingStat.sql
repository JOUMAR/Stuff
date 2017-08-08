BEGIN;

DROP TABLE IF EXISTS bet.copytrading_bet;
DROP TABLE IF EXISTS bet.copytrading_statistic;

CREATE TABLE bet.copytrading_bet (
       trader_id varchar(12) NOT NULL,
       parent_contract_id BIGINT NOT NULL,
       copied_contract_id BIGINT PRIMARY KEY,
       ctime timestamp DEFAULT current_timestamp
);
CREATE INDEX copytrading_bet_idx on bet.copytrading_bet(trader_id, parent_contract_id);
GRANT SELECT, UPDATE, INSERT, DELETE ON bet.copytrading_bet to read, write;

CREATE TABLE bet.copytrading_statistic (
       trader_id varchar(12) PRIMARY KEY,
       copiers_cnt integer DEFAULT 0,
       active_since timestamp DEFAULT current_timestamp,
       profitable jsonb,
       cnt_trades_loss integer DEFAULT 0,
       cnt_trades_win integer DEFAULT 0,
       avg_duration BIGINT DEFAULT 0,
       performance_probability numeric(8,4) DEFAULT 0,
       trades_breakdown jsonb
);
GRANT SELECT, UPDATE, INSERT, DELETE ON bet.copytrading_statistic to read, write;

COMMIT;

-- FUNCTION --
BEGIN;

DROP FUNCTION IF EXISTS update_copytrading_statistics ();

CREATE FUNCTION update_copytrading_statistics ()
RETURNS VOID AS $def$
BEGIN

  DROP TABLE IF EXISTS copytrading_contracts;
  CREATE TEMPORARY TABLE copytrading_contracts AS
  SELECT  trn_a.client_loginid AS trader_id,
          fmb.buy_price,
          fmb.sell_price,
          underlying_symbol,
          date_part( 'year', fmb.sell_time ) AS b_year,
          date_part( 'month', fmb.sell_time ) AS b_month,
          extract ( 'epoch' from fmb.expiry_time - fmb.start_time) AS duration
   FROM ONLY bet.financial_market_bet fmb
   JOIN transaction.account trn_a ON trn_a.id = fmb.account_id
   WHERE EXISTS (SELECT 1 FROM bet.copytrading_bet cb WHERE parent_contract_id = fmb.id);

  DELETE FROM bet.copytrading_statistic;

  INSERT INTO bet.copytrading_statistic
  SELECT cb.trader_id,
         (SELECT COUNT(*) FROM betonmarkets.copiers bc1 WHERE cb.trader_id = bc1.trader_id                                                ) AS copiers_count,
         (SELECT bet.ctime FROM bet.copytrading_bet bet WHERE bet.trader_id = cb.trader_id ORDER BY bet.ctime LIMIT 1                     ) AS active_since,
         (SELECT jsonb_object_agg(json_res.key, json_res.value )
          FROM ( SELECT json_build_object( b.b_year, json_object_agg(b.b_month, b.b_cnt)) AS res
                 FROM ( SELECT b_year, b_month, COUNT(*) as b_cnt
                        FROM copytrading_contracts cc
                        WHERE cc.trader_id = cb.trader_id
                        GROUP BY 2,1
                      ) AS b GROUP BY b.b_year
                 ) AS b1,
                 json_each(b1.res) AS json_res                                                                                            ) AS profitable,
         (SELECT SUM(CASE WHEN buy_price >= sell_price THEN 1 ELSE 0 END) FROM copytrading_contracts cc WHERE cc.trader_id = cb.trader_id ) AS cnt_trades_loss,
         (SELECT SUM(CASE WHEN buy_price < sell_price THEN 1 ELSE 0 END) FROM copytrading_contracts cc WHERE cc.trader_id = cb.trader_id  ) AS cnt_trades_win,
         (SELECT AVG(duration) FROM copytrading_contracts cc WHERE cc.trader_id = cb.trader_id                                            ) AS avg_duration,
         (SELECT (CASE WHEN SUM( buy_price ) > 0
                       THEN ( SUM(sell_price - buy_price) / SUM( buy_price ) ) * 100
                       ELSE 0 END)
          FROM bet.financial_market_bet fmb
          JOIN transaction.account trn_a ON trn_a.id = fmb.account_id
          WHERE trn_a.client_loginid = cb.trader_id                                                                                       ) AS performance_probability,
         (SELECT jsonb_object_agg(json_res.key, json_res.value)
          FROM ( SELECT json_build_object( underlying_symbol, COUNT(*)) AS res
                 FROM copytrading_contracts cc
                 WHERE cc.trader_id = cb.trader_id
                 GROUP BY underlying_symbol ) AS b,
                 json_each(b.res) AS json_res                                                                                             ) AS trades_breakdown
   FROM bet.copytrading_bet cb
   WHERE EXISTS( SELECT 1 FROM betonmarkets.copiers bc WHERE cb.trader_id = bc.trader_id )
   GROUP BY cb.trader_id;

END;
$def$ LANGUAGE plpgsql VOLATILE;

COMMIT;
