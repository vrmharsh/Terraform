terraform {
  
}  /* we are just working with functinality and no 
providers is used over here so we jsut write this. 
We are not pushing anything on cloud using terraform. */


locals {
    value = "Hello World"
}

variable "string-list" {
  type = list(string)
  default = ["server1", "Server2", "Server3", "Server4"]
}

output "string-list-for-Test-function" {
  value = upper(local.value) /* or lower(lower.vaue) */
  /* over here we can change the format to upper and lower case by just typing this work and then the output value we are fetching from the
     local variable.
   */
}

// Below is the functionality to test if my local.value is starting with "Hello" or not
output "startswith" {
  value = startswith(local.value, "Hello")
}


// Below is the functionality to have some space between my local.value.

output "split" {
    value = split(" ", local.value) // this is the format
}


// Below is the functionality to count the number of integer value

output "max-min-number-of-value" {
  value = max(1,2,3,4,5)
  /* value = min(1,2,3,4,5) */
}


// Below is the functionality to test the length of the variable
/* most important */

output "length" {
  value = length(var.string-list)
}

// Below is the functionality to join the variables

output "join" {
    value = join(":", var.string-list)
}


// Below is the functionality to test if the particular value is present in your list or not.

output "contains" {
    value = contains(var.string-list, "server" ) 
    /* this will tell if my string-list has the value by the name "server" */
}


// Below is the fuctionality to change the list to set and it does not allow any duplicate entry.

output "no-dupicate" {
    value = toset(var.string-list)
    /* this change the list to set and does not print if any duplicate entry was made to list */
}