#########################################################################################
#                                                                                       #
#   .sh for tracking internet package loss                                              #
#   packageLoss.txt will store every failure of response from pinging selected address  #
#                                                                                       #
#   Run -> sh packageLoss.sh URL/IP                                                     #
#                                                                                       #
#########################################################################################

#Number of packages that will be sent for target address (default = 10)
packages=10
echo "Sending $packages packages to $1..."
    
while true
do
    data=`date '+%Y-%m-%d %H:%M:%S'`
    #echo "data = $data"
    
    #$1 = target internet address
    #Keeps only the last line from ping result
    lastLine=$(ping -c $packages $1 | grep 'loss')
    
    #Cut third column from lastLine
    lossColumn=$(echo $lastLine | cut -d ',' -f 3)

    #Stores the number of lost packages for comparing 
    lost=$(echo $lossColumn | cut -c1-1)
    echo "[$data] $lost packages lost"
    
    #if lost packages different from zero - stores time + number of packages lost in output txt file
    if [ $lost != '0' ]
        then
            echo "[$data]$lossColumn" >> packageLoss.txt
            #Run tail -f packageLoss.txt to check output file
    fi
done

#########################################################################################
#                                Created by Joao Vieira                                 #
#########################################################################################