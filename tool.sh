
#!/bin/bash

arg=$#
count=$#

#βρογχος για ανακτηση της εντολης απo τον χρηστη
while [ $arg -gt 0 ]; do
(( arg-- ))
 case $1 in
  "-f")
   l1=true
   shift 1
   file=$1
   shift 1
   (( arg-- ));;
  "-id")
   l2=true
   shift 1
   id=$1
   shift 1
   (( arg-- ));;
  "--firstnames")
   shift 1
   l3=true;;
  "--lastnames")
   shift 1
   l4=true;;
  "--born-since")
   l5=true
   shift 1
   dateA=$1
   shift 1;;
  "--born-until")
   l6=true
   shift 1
   dateB=$1
   shift 1;;
  "--socialmedia")
   l7=true
   shift 1;;
  "--edit")
   l8=true
   shift 1
   ID=$1
   shift 1
   column=$1
   shift 1
   value=$1
   shift 1;;
 esac
done

#αναληση περιπτωσεων και πραξεις
if [ $count == 0 ]; then
 #περιπτωση 1a
 echo "1054380-1054293"
elif [ $count == 2 ]; then
 if [ $l1 ]; then
  #περιπτωση ερωτημστος 1b
  grep -v '^#' $file
 fi
elif [ $count == 3 ]; then
 if [ $l3 ]; then
 #περιπτωση ερωτηματος 3a
	#olos o parakato kodikas mporei na dothei apo thn entolh :
	#grep -v '^#' $file | awk 'BEGIN{ FS="|"} {print $3}' | sort | uniq
  j=0
 grep -v '^#' $file | { while read line; do
  i=0
   IFS='|'
  for word in $line; do
   if [ $i == 2 ] ; then
    B[$j]=$word
   fi
   (( i++ ))
  done
  unset IFS
  (( j++ ))
 done

 i=0
 while [ $i -lt $j ]; do
  echo ${B[$i]}
  (( i++ ))
 done | sort | uniq 
 }
 elif [ $l4 ]; then
  #περιπτωση ερωτηματος 3b
	#olos o parakato kodikas mporei na dothei apo thn entolh :
        #grep -v '^#' $file | awk 'BEGIN{ FS="|"} {print $2}' | sort | uniq
  j=0
  grep -v '^#' $file | { while read line; do
  i=0
  IFS='|'
  for word in $line; do
   if [ $i == 1 ]; then
    B[$j]=$word
   fi
   (( i++ ))
  done
  (( j++ ))
  unset IFS
 done

  i=0
  while [ $i -lt $j ]; do
   echo ${B[$i]}
   (( i++ ))
  done | sort | uniq
 }
 elif [ $l7 ]; then
  #περιπτωση ερωτηματος 5a
  k=0
  n=0
 grep -v '^#' $file |{ while read line; do
  i=0
  IFS='|'
  for word in $line; do
   if [ $i == 8 ]; then
      SM[$n]=$word
      (( n++ ))
   fi
  (( i++ ))
  done
  (( k++ ))
done

i=0

  while [ $i -lt $n ]; do
   echo "${SM[$i]}"
   (( i++ ))
  done | sort | uniq -c | awk '{ if (NF == 2) printf("%s\t %s\n" ,$2,$1); else print $2,$3,$1}'
unset IFS
}
 fi
elif [ $count == 4 ]; then
 if [ $l2 ]; then
  #περιπτωση ερωτηματος 2
  w=`whoami` #για καποιο λογο δεν λειτουργουσε χωρις αυτο
  f=`grep -v '^#' $file | grep "^\$id|"` 
  i=0
  IFS='|'
  for word in $f; do
   if [ $i == 1 ] || [ $i == 2 ] || [ $i == 4 ] ; then
    B[$i]="$word"
   fi
   (( i++ ))
  done
  unset IFS
  echo ${B[2]} ${B[1]} ${B[4]}
 elif [ $l5 ]; then
  #περιπτωση ερωτηματος 4 με την εντολη --born-since
j=0
d2=`echo "$dateA" | tr "-" "|"
   for d in $d2; do
    D2[$j]=$d
    (( j++ ))
   done
k=0
 grep -v '^#' $file |  while read line; do
  i=0
  IFS='|'
  for word in $line; do
   if [ $i == 4 ] && [ $k != 0 ]; then
   j=0
   d1=`echo "$word" | tr "-" "|"
   for d in $d1; do
    D[$j]=$d
    (( j++ ))
    done
   unset IFS
      if [ ${D[0]} \> ${D2[0]} ]; then
        echo $line
      elif [ ${D[0]} == ${D2[0]} ]; then
        if [ ${D[1]} \> ${D2[1]} ]; then
          echo $line
        elif [ ${D2[1]} == ${D[1]} ]; then
          if [ ${D[2]} \> ${D2[2]} ]; then
           echo $line
          elif [ ${D[2]} == ${D2[2]} ]; then
           echo $line
          fi
        fi
    fi
 fi
   (( i++ ))
  done
  unset IFS
  (( k++ ))
 done
 elif [ $l6 ]; then
  #περιπτωση ερωτηματος 4 με την εντολη --born-until
 j=0
d2=`echo "$dateB" | tr "-" "| "
   for d in $d2; do
    D2[$j]=$d
    (( j++ ))
   done
k=0
 grep -v '^#' $file |  while read line; do
  i=0
  IFS='|'
  for word in $line; do
   if [ $i == 4 ] && [ $k != 0 ]; then
   j=0
   d1=`echo "$word" | tr "-" "|"
   for d in $d1; do
    D[$j]=$d
    (( j++ ))
    done
   unset IFS
      if [ ${D[0]} \< ${D2[0]} ]; then
        echo $line
      elif [ ${D[0]} == ${D2[0]} ]; then
        if [ ${D[1]} \< ${D2[1]} ]; then
          echo $line
        elif [ ${D2[1]} == ${D[1]} ]; then
          if [ ${D[2]} \< ${D2[2]} ]; then
           echo $line
          elif [ ${D[2]} == ${D2[2]} ]; then
           echo $line
          fi
        fi
    fi
 fi
   (( i++ ))
  done
  unset IFS
  (( k++ ))
 done
 fi
elif [ $count == 6 ]; then
 if [ $l5 ] && [ $l6 ]; then
   #περιπτωση ερωτηματος 4 με την εντολη --born-since  --born-until
  j=0
d2=`echo "$dateA" | tr "-" "| "
   for d in $d2; do
    D2[$j]=$d
    (( j++ ))
   done
j=0
d3=`echo "$dateB" | tr "-" "|"
   for d in $d3; do
    D3[$j]=$d
    (( j++ ))
   done

k=0
 grep -v '^#' $file |  while read line; do
  i=0
  IFS='|'
  for word in $line; do
   if [ $i == 4 ] && [ $k != 0 ]; then
   j=0
   d1=`echo "$word" | tr "-" "|"
   for d in $d1; do
    D[$j]=$d
    (( j++ ))
    done
   unset IFS
      if [ ${D[0]} \> ${D2[0]} ] && [ ${D[0]} \< ${D3[0]} ]; then
           echo $line
      elif [ "${D[0]}" == "${D2[0]}" ] && [ "${D[0]}" != "${D3[0]}" ]; then
           if [ ${D[1]} \> ${D2[1]} ]; then
               echo $line
           elif [ ${D2[1]} == ${D[1]} ]; then
                if [ ${D[2]} \> ${D2[2]} ]; then
                    echo $line
                elif [ ${D[2]} == ${D2[2]} ]; then
                    echo $line
                fi
            fi
      elif [ "${D[0]}" != "${D2[0]}" ] && [ "${D[0]}" == "${D3[0]}" ]; then
            if [ ${D[1]} \< ${D3[1]} ]; then
                echo $line
            elif [ ${D3[1]} == ${D[1]} ]; then
                if [ ${D[2]} \< ${D3[2]} ]; then
                   echo $line
                elif [ ${D[2]} == ${D3[2]} ]; then
                   echo $line
                fi
            fi
       elif [ ${D[0]} == ${D2[0]} ] && [ ${D[0]} == ${D3[0]} ]; then
            if [ ${D[1]} \> ${D2[1]} ] && [ ${D[1]} \< ${D3[1]} ]; then
                echo $line
            elif [ ${D3[1]} == ${D[1]} ] && [ ${D2[1]} != ${D[1]} ]; then
                if [ ${D[2]} \< ${D3[2]} ]; then
                    echo $line
                elif [ ${D[2]} == ${D3[2]} ]; then
                    echo $line
                fi
             elif [ ${D3[1]} != ${D[1]} ] && [ ${D2[1]} == ${D[1]} ]; then
                 if [ ${D[2]} \> ${D2[2]} ]; then
                     echo $line
                 elif [ ${D[2]} == ${D3[2]} ]; then
                     echo $line
                 fi
             elif [ "${D3[1]}" == "${D[1]}" ] && [ "${D2[1]}" == "${D[1]}" ]; then
                 if [ ${D[2]} \> ${D2[2]} ] && [ ${D[2]} \< ${D3[2]} ]; then
                     echo $line
                 elif [ ${D[2]} == ${D2[2]} ] || [ ${D[2]} == ${D3[2]} ]; then
                     echo $line
                 fi
             fi
        fi
   fi
   (( i++ ))
  done
  unset IFS
  (( k++ ))
 done
elif [ $l8 ]; then
  #περιπτωση ερωτηματος 5b


(( column-- ))
if [ $column -ge 1 ] && [ $column -le 7 ]; then
  if grep -q $ID $file;then
     f=`grep $ID $file`
     i=0
     IFS='|'
      for word in $f; do
       F[i]=$word
       if [ $i == $column ]; then
          word=$value
          F[i]=$word
       fi
       (( i++ ))
      done
      unset IFS
   fi
  i=0
  nf=`while [ $i -le 7 ]; do
    if [ $i == 7 ]; then
     echo -n "${F[$i]}"
    else
     echo -n "${F[$i]}|"
    fi
    (( i++ ))
    done`
sed -i "s@$f@$nf@" "$file"

fi

 fi 
fi
