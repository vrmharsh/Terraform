terraform {

}

#Number list using terraform
// 1 

variable "num-list" {   // name of the list is num-list
  type = list(number)   // type is list and list's type is number or integer value
  default = [ 1,2,3,4,5 ]  // number given in that list
}


#Object list
// 2.
variable "object-list" {
 type = list(object({   // object is person over here with first name and last name
  fname = string  // first name type should be string.
  lname =  string // last name type should be string.
 }))
 default = [ {   // below are just random names given by you. So, this is just an example of creating object list and storing some user data.
   fname = "abc"
   lname = "cba"
 }, 
 {
    fname = "acer"
    lname = "predator"
 }
  ]
}


# map-list: to map somethings.

// 3. 

variable "map-number" {
  type = map(number)  // map is always in key value-pair
  default = {
    "name" = 1,
    "One"= 1,
    "two"= 2
  }
}


//So, the above were the example of how data can be stored and used in terraform.
  

// Calculations:
locals { // by this we can catch or fetch the above or other variabls and play with them
    double = [for a in var.num-list: a*2 ]  // fetching variable by the name num-list and storing it in a, then multiplying it with 2 and finally storing in "double"
    // the above double is just the name storing the value.
}

output "output" {
  value = var.num-list // variable name num-list has been fetched and the output will be shown when you do "terraform plan"
}

output "output-for-doubling-the-list-number" {
  value = local.double  // here we are fetching the "local variable" name double and providing the output in terminal.
}


locals {
     # odd numbers:
    odd = [ for a in var.num-list: a if a%2 !=0 ]
}


output "odd-numbers" {
 value = local.odd
}

//all the above was the example of using a number lists.

// Now let use the "object list" created above to fetch the first name only:


locals {
  first-name= [for a in var.object-list: a.fname]
}

output "for-object-lists" {
  value = local.first-name
}


// now let's see how to fetch anything from map list which is list number 3.


locals {
   abc = [ for key, value in var.map-number: value]  /* "map" type variable is alaways in key-value pair. So, you will need to use attributes 
   in key-value pair after for. Then you can fetch whichever value you want to fetch. */
}

output "fetch-map-list-3rd-one" {
    value = local.abc
}


// now use the above concept to fetch the map value and double it then print it in the terminal:


locals {
   abc-double = [ for key, value in var.map-number: value*2]  

}

output "fetch-map-list-3rd-one-value-multiple-by-2" {
    value = local.abc-double
}

// Now the same concept, only thing is that you need to create new list:

locals {
   abc-double-list = { for key, value in var.map-number: key => value*2 }   
   /* here we are not using [] because we are creating a new list itself with new values. 
   So, we use this {} and key => is to target "key" that has some value and then we multiply it by 2. 
   
   Also, you can target both key-value of the map list.
   
   */

}

output "fetch-map-list-3rd-one-value-multiple-by-2-and-created-new-list" {
    value = local.abc-double-list
}