# Remove-vRAStorageReservationPolicy

## SYNOPSIS
    
Remove a vRA Storage Reservation Policy

## SYNTAX


## DESCRIPTION

Remove a vRA Storage Reservation Policy

## PARAMETERS


### Id

Storage Reservation Policy ID

* Required: true
* Position: named
* Default value: 
* Accept pipeline input: true (ByValue, ByPropertyName)

### Name

Storage Reservation Policy Name

* Required: true
* Position: named
* Default value: 
* Accept pipeline input: true (ByPropertyName)

### WhatIf


* Required: false
* Position: named
* Default value: 
* Accept pipeline input: false

### Confirm


* Required: false
* Position: named
* Default value: 
* Accept pipeline input: false

## INPUTS

System.String.

## OUTPUTS

None

## EXAMPLES
```
-------------------------- EXAMPLE 1 --------------------------

C:\PS>Remove-vRAStorageReservationPolicy -Id "34ae1d6c-9972-4736-acdb-7ee109ad1dbd"







-------------------------- EXAMPLE 2 --------------------------

C:\PS>Remove-vRAStorageReservationPolicy -Name "StorageReservationPolicy01"







-------------------------- EXAMPLE 3 --------------------------

C:\PS>Get-vRAStorageReservationPolicy -Name "StorageReservationPolicy01" | Remove-vRAStorageReservationPolicy -Confirm:$false
```
