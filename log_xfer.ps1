#Xfer logs to a location, to be placed in an OSD task sequence wherever you want

#you will need a resource account with access to the folder, and a folder

#Creating the Secure String File with your password and writing it to a file 
#------------
#read-host -assecurestring | convertfrom-securestring | out-file C:\pw_file.txt
#------------

$user = 'jjm06012admin'
$pass = get-content 'pw_file.txt' | convertto-securestring
#$credential = new-object -typename System.Management.Automation.PSCredential -argumentlist $user,$pass
$credential = New-Object System.Management.Automation.PSCredential ($user,$pass)
$network_path = '\\cm12-test.testgrove.testad.uconn.edu\dsl\osd\logs'

New-PSDrive -Name Logs -PSProvider FileSystem -Root $network_path -Credential $credential


$date = Get-Date -UFormat "%y_%m_%d-%H_%M"
$hostname = hostname 
$new_dir = "Logs:\"+$hostname+$date
mkdir $new_dir
cp c:\Windows\CCM\logs\* $new_dir