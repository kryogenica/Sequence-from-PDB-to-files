#! /bin/csh -f

phenix.print_sequence $1 > sequence.txt

#Deletes any white lines.
sed -i '/^\s*$/d' sequence.txt

#phenix.print_sequence might re print a chain with "??" as a sequence the line below corrects that.
tac sequence.txt | sed '/??/I,+1 d' | tac > sequence.temp

rm sequence.txt

mv sequence.temp sequence.txt

set Chains=`grep "Chain" sequence.txt | grep -o '.$'` 

set A=1

foreach x ($Chains)
 
 awk "/Chain=$x/{flag=1;next}/Chain/{flag=0}flag" sequence.txt > $x.temp

 tr -d '\n' < $x.temp > $x.seq

 rm $x.temp

end

rm sequence.txt
