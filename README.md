# BASH Shell
The event.dat contains elements according to the following lineup: 

id|lastName|firstName|gender|birthday|joinDate|IP|browserUsed|socialmedia


The program will support the following functions:
1. Without any parameter: it will display the Student-ID
2. Running this command ./tool.sh -f <file> -id <if> : it will display name, lastname, date of brith of the user with this specified <id>
3. Running this command ./tool.sh --firstnames -f <file> and ./tool.sh --lastnames -f <file> : it will display all the names and the lastnames alphabetically
4. Running this command ./tool.sh --born-since <dateA> --born-until <dateB> -f <file> : it will display the users who have been born from <dateA> to <dateB>
5. Running this command ./tool.sh --socialmedia -f <file> : it will display the social media that used, alphabetically.

