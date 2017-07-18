for i in `ls -1`; do ( [[ $i =~ ^bom|binary|cpan|perl ]] && cd $i && git checkout -q master && git pull -q origin master  & ) done;

for i in `ls -1`; do  echo $i; cd $i; git remote add -f vladimir git@github.com:melnichenko-binary/$i.git; cd ..;  done;
