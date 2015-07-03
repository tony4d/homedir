#!/bin/bash
 
function luhn_validate  # <numeric-string>
{
    num=$1
    shift 1
 
    len=${#num}
    is_odd=1
    sum=0
    for((t = len - 1; t >= 0; --t)) {
        digit=${num:$t:1}
 
        if [[ $is_odd -eq 1 ]]; then
            sum=$(( sum + $digit ))
        else
            sum=$(( $sum + ( $digit != 9 ? ( ( 2 * $digit ) % 9 ) : 9 ) ))
        fi
 
        is_odd=$(( ! $is_odd ))
    }
 
    # NOTE: returning exit status of 0 on success
    return $(( 0 != ( $sum % 10 ) ))
}
sedsub='s/[0-9]*\([0-9]\{4\}\)/\1/'
echo "Enter a payment card PAN to luhn check:"
read -s pan

if luhn_validate "$pan"; then
    echo -e "\033[32mPAN ending in $pan PASSED the luhn check" | sed -e $sedsub
else
    echo -e "\033[31mPAN ending in $pan FAILED the luhn check" | sed -e $sedsub
fi