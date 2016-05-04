function checkForm(frm)
{
// Check form inputs in order. Check if inputs from warranty form exists so same function can be used on warranty form
    if( !checkInput(frm.contactName, "Please Enter Your Name in the Form") )
        return false;

    if( frm.contactEmail.value == "" && frm.contactDayPhone.value == "" && frm.contactEvePhone.value == "" )
        if( frm.contactCellPhone != null )
        {
            if( frm.contactCellPhone.value == "" )
                return checkInput(frm.contactEmail, "Please Enter An Email Address or a Phone Number so We Can Contact You");
        }
        else
            return checkInput(frm.contactEmail, "Please Enter An Email Address or a Phone Number so We Can Contact You");

    if( frm.contactCommunity != null )
        if( !checkInput(frm.contactCommunity, "Please Enter the Community in Which Your House Was Built") )
            return false;

    if( frm.contactFloorPlan != null )
        if( !checkInput(frm.contactFloorPlan, "Please Enter Your FloorPlan Type for Warranty Request") )
            return false;

    if( frm.contactClosing != null )
        if( !checkInput(frm.contactClosing, "Please Enter the Closing Date on Your House for Warranty Request") )
            return false;

    if( !checkInput(frm.contactMessage, "Please Enter a Message in the Form") )
        return false;

    if( !checkInput(document.getElementById('captcha_code'), "Please Enter the Answer to the Security Question") )
        return false;

    return true;
}

function checkInput(input, msg)
{
    if( input.value == "" )
    {
        alert(msg);
        input.focus();
        return false;
    }
    return true;
}