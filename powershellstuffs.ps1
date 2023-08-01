# Define the LDAP query to retrieve SamAccountName
$ldapQuery = "(&(objectCategory=User)(objectClass=User)(sAMAccountName=*))"

# Set the domain controller or leave it empty for the default domain controller
$domainController = ""

# Create a new DirectorySearcher
$searcher = New-Object System.DirectoryServices.DirectorySearcher

# Set the searcher's properties
$searcher.SearchRoot = "LDAP://$domainController"
$searcher.Filter = $ldapQuery
$searcher.PageSize = 1000
$searcher.PropertiesToLoad.Add("sAMAccountName") # Add other attributes as needed

# Perform the search and get the results
$searchResults = $searcher.FindAll()

# Process the results
foreach ($result in $searchResults)
{
    $samAccountName = $result.Properties["sAMAccountName"][0]
    Write-Output $samAccountName
}

# Dispose the searcher object
$searcher.Dispose()
