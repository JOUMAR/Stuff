#!/usr/bin/perl -wl
 
use strict;
use bytes;
### Программа сравнивает два файла, находит строки, которые есть в первом, но нет во втором и записывает в третий
open( my $input_1, '<', $ARGV[0] || "input_1.txt" ) or die "Can't open input_1!";
open( my $input_2, '<', $ARGV[1] || "input_2.txt" ) or die "Can't open input_1!";
open( my $output,  '>', $ARGV[2] || "output.txt" ) or die "Can't open output!";
 
my $block_size = $ARGV[3] || 100;
$block_size *= 1024*1024; # Из мегабайтов в байты
 
print "Start";
 
while ( !eof( $input_1 ) ) { ### Читаем первый файл
    my $b = read_block();    ### Сохраняяем блок в хеше
    while ( my $line_2 = <$input_2> ) { ### Читаем второй файл и вычеркиваем из хеша строки, которые встречаются во втором файле
        # удалим пересечения
        delete $b->{$line_2} if ( $b->{$line_2} );
    }
    ### запись фильтрованного массива в файл
    print $output $_ foreach ( keys %$b );
    seek( $input_2, 0, 0 ); #переходим в начало файла
}
 
print "Done";
 
close( $input_2 );
close( $input_1 );
close( $output );
 
### Строки из первого файла читаются блоками не больше установленного размера
sub read_block {
    my $block;
    my $cur_size = 0;
 
    while ( $cur_size < $block_size ) {
        my $line_1 = <$input_1>;
        last unless $line_1;
        $cur_size += length( $line_1 );
        my $size = int($cur_size / ( 1024 * 1024 ));
        ### Оформляем в виде хэша
        $block->{$line_1} = 1;
    }
    return $block;
}
 
1;
