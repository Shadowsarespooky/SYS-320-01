. "C:\Users\champuser\SYS-320-Automation-and-scripting\week6\Event-Logs.ps1"
. "C:\Users\champuser\SYS-320-Automation-and-scripting\week7\Email.ps1"
. "C:\Users\champuser\SYS-320-Automation-and-scripting\week7\Configuration.ps1"
. "C:\Users\champuser\SYS-320-Automation-and-scripting\week7\Scheduler.ps1"

# Obataining configuration
$configuration = readConfiguration

# Obtaining at risk users
$Failed = atRiskUsers $configuration.Days

# Sending at risk users as email
SendAlertEmail ($Failed | Format-Table | Out-String)

# Setting the script to be run daily
ChooseTimeToRun($configuration.ExecutionTime)