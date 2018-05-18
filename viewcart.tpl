<link rel="stylesheet" type="text/css" href="templates/orderforms/{$carttpl}/style.css" />
<script language="javascript">
    // Define state tab index value
    var statesTab = 10;
{if in_array('state', $clientsProfileOptionalFields)}
    // Do not enforce state input client side
    var stateNotRequired = true;
{/if}
</script>
<script type="text/javascript" src="templates/orderforms/{$carttpl}/js/main.js"></script>
<script type="text/javascript" src="{$BASE_PATH_JS}/StatesDropdown.js"></script>
<script type="text/javascript" src="{$BASE_PATH_JS}/PasswordStrength.js"></script>
<script type="text/javascript" src="{$BASE_PATH_JS}/CreditCardValidation.js"></script>

{literal}<script language="javascript">
function removeItem(type,num) {
    var response = confirm("{/literal}{$LANG.cartremoveitemconfirm}{literal}");
    if (response) {
        window.location = 'cart.php?a=remove&r='+type+'&i='+num;
    }
}
function emptyCart(type,num) {
    var response = confirm("{/literal}{$LANG.cartemptyconfirm}{literal}");
    if (response) {
        window.location = 'cart.php?a=empty';
    }
}

jQuery(document).ready(function() {
    var preparePromoCode = function(ctx) {
        jQuery(ctx).parents('form').attr('novalidate', 'novalidate');
        jQuery('#validatepromo').val('1');
    };

    jQuery('#validatePromoCode').click(function() {
        preparePromoCode(this);
        jQuery('#btnCompleteOrder').click();
    });

    jQuery('#inputPromoCode').keydown(function(evt) {
        if (evt.keyCode == 13) {
            preparePromoCode(this);
            // Enter in a form will submit the form
        }
    });
});
</script>{/literal}
<script>
window.langPasswordStrength = "{$LANG.pwstrength}";
window.langPasswordWeak = "{$LANG.pwstrengthweak}";
window.langPasswordModerate = "{$LANG.pwstrengthmoderate}";
window.langPasswordStrong = "{$LANG.pwstrengthstrong}";
</script>
{include file="orderforms/$carttpl/header.tpl"}

<div id="order-modern">

    <div class="text-center">
        <h1>Step 1 of 3 : Review your order</h1>
    </div>

    {if $errormessage}
        <div class="errorbox" style="display:block;">
            {$errormessage|replace:'<li>':' &nbsp;#&nbsp; '} &nbsp;#&nbsp;
        </div>
    {elseif $promotioncode && $rawdiscount eq "0.00"}
        <div class="errorbox" style="display:block;">
            {$LANG.promoappliedbutnodiscount}
        </div>
    {/if}

    {if $bundlewarnings}
        <div class="cartwarningbox">
            <strong>{$LANG.bundlereqsnotmet}</strong><br />
            {foreach from=$bundlewarnings item=warning}
                {$warning}<br />
            {/foreach}
        </div>
    {/if}

    {if !$loggedin && $currencies}
        <div class="currencychooser">
            <div class="btn-group" role="group">
                {foreach from=$currencies item=curr}
                    <a href="cart.php?a=view&currency={$curr.id}" class="btn btn-default{if $currency.id eq $curr.id} active{/if}">
                        <img src="{$BASE_PATH_IMG}/flags/{if $curr.code eq "AUD"}au{elseif $curr.code eq "CAD"}ca{elseif $curr.code eq "EUR"}eu{elseif $curr.code eq "GBP"}gb{elseif $curr.code eq "INR"}in{elseif $curr.code eq "JPY"}jp{elseif $curr.code eq "USD"}us{elseif $curr.code eq "ZAR"}za{else}na{/if}.png" border="0" alt="" />
                        {$curr.code}
                    </a>
                {/foreach}
            </div>
        </div>
    {/if}

    <form method="post" action="{$smarty.server.PHP_SELF}?a=view">
		<table class="cart" cellspacing="1">
            <tbody>
            	<tr class="co-border-bottom">
                    <th width="60%">{$LANG.orderdesc}</th>
                    <th width="40%">{$LANG.orderprice}</th>
                </tr>
            </tbody>
        </table>
        <table class="cart cart-table" cellspacing="10">

            {foreach key=num item=product from=$products}
                <tr class="carttableproduct">
                    <td width="60%" id="productDesc">
                    
                     <strong class="hidden-xs product-name-text">{$product.productinfo.groupname} - {$product.productinfo.name}</strong>
                     <strong class="hidden-lg zero-margins">{$product.productinfo.groupname} - {$product.productinfo.name}</strong>
                     {if $product.domain} ({$product.domain}){/if}<br class="hidden-xs" /><br class="hidden-xs" />
                               
                                    
                      <span class="hidden-xs" style="font-size: 14px;">We've added one server into this plan. Add more servers here:</span>
                            
                        {if $product.configoptions}
                            {foreach key=confnum item=configoption from=$product.configoptions}
		                        &nbsp;<br class="hidden-xs"><span class="hidden-xs" id="subProduct"> {$configoption.name}: {if $configoption.type eq 1 || $configoption.type eq 2}{$configoption.option}{elseif $configoption.type eq 3}{if $configoption.qty}{$LANG.yes}{else}{$LANG.no}{/if}{elseif $configoption.type eq 4}{$configoption.qty} x {$configoption.option}{/if}</span>
                            {/foreach}
                            <br class="hidden-xs">
                        {/if}
                        </ul>
                        <a href="{$smarty.server.PHP_SELF}?a=confproduct&i={$num}" class="cartedit">[{$LANG.carteditproductconfig}]</a>
                        <a href="#" onclick="removeItem('p','{$num}');return false" class="cartremove">[{$LANG.cartremove}]</a>
                        {if $product.allowqty}
                        <br class="hidden-xs" /><br class="hidden-xs" />
                        <div align="right">{$LANG.cartqtyenterquantity} <input type="text" name="qty[{$num}]" size="3" value="{$product.qty}" /> <input type="submit" value="{$LANG.cartqtyupdate}" class="btn btn-default btn-sm" /></div>
                        {/if}
                    </td>
                    <td width="40%" id="productPrice" class="text-center">
                        <strong class="hidden-xs">{$product.pricingtext}{if $product.proratadate}<br />({$LANG.orderprorata} {$product.proratadate}){/if}</strong>
                        <span class="small-text zero-margins hidden-lg">{$product.pricingtext}{if $product.proratadate}<br />({$LANG.orderprorata} {$product.proratadate}){/if}</span>
                    </td>
                </tr>
                {foreach key=addonnum item=addon from=$product.addons}
                    <tr class="carttableproduct">
                        <td><strong>{$LANG.orderaddon}</strong> - {$addon.name}</td>
                        <td class="text-center"><strong>{$addon.pricingtext}</strong></td>
                    </tr>
                {/foreach}
            {/foreach}

            {foreach key=num item=addon from=$addons}
                <tr class="carttableproduct">
                    <td>
                        <strong>{$addon.name}</strong><br />
                        {$addon.productname}{if $addon.domainname} - {$addon.domainname}<br />{/if}
                        <a href="#" onclick="removeItem('a','{$num}');return false" class="cartremove">[{$LANG.cartremove}]</a>
                    </td>
                    <td class="text-center"><strong>{$addon.pricingtext}</strong></td>
                </tr>
            {/foreach}

            {foreach key=num item=domain from=$domains}
                <tr class="carttableproduct">
                    <td>
                        <strong>{if $domain.type eq "register"}{$LANG.orderdomainregistration}{else}{$LANG.orderdomaintransfer}{/if}</strong> - {$domain.domain} - {$domain.regperiod} {$LANG.orderyears}<br />
                        {if $domain.dnsmanagement}&nbsp;&raquo; {$LANG.domaindnsmanagement}<br />{/if}
                        {if $domain.emailforwarding}&nbsp;&raquo; {$LANG.domainemailforwarding}<br />{/if}
                        {if $domain.idprotection}&nbsp;&raquo; {$LANG.domainidprotection}<br />{/if}
                        <a href="{$smarty.server.PHP_SELF}?a=confdomains" class="cartedit">[{$LANG.cartconfigdomainextras}]</a>
                        <a href="#" onclick="removeItem('d','{$num}');return false" class="cartremove">[{$LANG.cartremove}]</a>
                    </td>
                    <td class="text-center">
                        <strong>{$domain.price}</strong>
                    </td>
                </tr>
            {/foreach}

            {foreach key=num item=domain from=$renewals}
                <tr class="carttableproduct">
                    <td>
                        <strong>{$LANG.domainrenewal}</strong> - {$domain.domain} - {$domain.regperiod} {$LANG.orderyears}<br />
                        {if $domain.dnsmanagement}&nbsp;&raquo; {$LANG.domaindnsmanagement}<br />{/if}
                        {if $domain.emailforwarding}&nbsp;&raquo; {$LANG.domainemailforwarding}<br />{/if}
                        {if $domain.idprotection}&nbsp;&raquo; {$LANG.domainidprotection}<br />{/if}
                        <a href="#" onclick="removeItem('r','{$num}');return false" class="cartremove">[{$LANG.cartremove}]</a>
                    </td>
                    <td class="text-center">
                        <strong>{$domain.price}</strong>
                    </td>
                </tr>
            {/foreach}

            {if $cartitems == 0}
                <tr class="clientareatableactive">
                    <td colspan="2" class="text-center">
                        <br />
                        {$LANG.cartempty}
                        <br /><br />
                    </td>
                </tr>
            {/if}
			</table>
            <table class="cart cart-total">
               <tbody>
                <tr class="total">
                    <td class="text-right total-text">{$LANG.ordertotalduetoday}: &nbsp;</td>
                    <td class="text-center total-value">{$total}</td>
                </tr>
            {if $promotioncode}
                <tr class="promotion">
                    <td class="text-right total-text">{$promotiondescription}: &nbsp;</td>
                    <td class="text-center total-value">{$discount}</td>
                </tr>
            {/if}
            {if $taxrate}
                <tr class="subtotal">
                    <td class="text-right total-text">{$taxname} @ {$taxrate}%: &nbsp;</td>
                    <td class="text-center total-value">{$taxtotal}</td>
                </tr>
            {/if}
            {if $taxrate2}
                <tr class="subtotal">
                    <td class="text-right total-text">{$taxname2} @ {$taxrate2}%: &nbsp;</td>
                    <td class="text-center total-value">{$taxtotal2}</td>
                </tr>
            {/if}
                {if $totalrecurringmonthly || $totalrecurringquarterly || $totalrecurringsemiannually || $totalrecurringannually || $totalrecurringbiennially || $totalrecurringtriennially}
                    <tr class="recurring">
                        <td class="text-right rc-text">{$LANG.ordertotalrecurring}: &nbsp;</td>
                        <td class="text-center rc-value">
                            {if $totalrecurringmonthly}{$totalrecurringmonthly} {$LANG.orderpaymenttermmonthly}<br />{/if}
                            {if $totalrecurringquarterly}{$totalrecurringquarterly} {$LANG.orderpaymenttermquarterly}<br />{/if}
                            {if $totalrecurringsemiannually}{$totalrecurringsemiannually} {$LANG.orderpaymenttermsemiannually}<br />{/if}
                            {if $totalrecurringannually}{$totalrecurringannually} {$LANG.orderpaymenttermannually}<br />{/if}
                            {if $totalrecurringbiennially}{$totalrecurringbiennially} {$LANG.orderpaymenttermbiennially}<br />{/if}
                            {if $totalrecurringtriennially}{$totalrecurringtriennially} {$LANG.orderpaymenttermtriennially}<br />{/if}
                        </td>
                    </tr>
                {/if}                
               </tbody>
            </table>

    </form>

    <div class="cartbuttons hidden-xs">
        <button type="button" class="btn btn-danger btn-sm" onclick="emptyCart();return false"><i class="fa fa-trash"></i> {$LANG.emptycart}</button>
        <a href="https://sysally.com/pricing/" class="btn btn-default btn-sm"><i class="fa fa-shopping-cart"></i> {$LANG.continueshopping}</a>
    </div>

	<div class="pull-left hidden-lg">
    	<table class="text-center">
        	<tbody>
            	<tr>
                	<td align="left" width="30%"><button type="button" class="btn btn-danger btn-sm" onclick="emptyCart();return false"><i class="fa fa-trash"></i> {$LANG.emptycart}</button></td>
        			<td align="right"><a href="https://sysally.com/pricing/" class="btn btn-default btn-sm"><i class="fa fa-shopping-cart"></i> {$LANG.continueshopping}</a></td>
 				</tr>
            </tbody>
        </table>
    </div>

    {foreach from=$gatewaysoutput item=gatewayoutput}
        <div class="clear"></div>
        <div class="cartbuttons">
            {$gatewayoutput}
        </div>
    {/foreach}



    {if $cartitems!=0}

        <form method="post" action="{$smarty.server.PHP_SELF}?a=checkout" id="frmCheckout">
            <input type="hidden" name="submit" value="true" />
            <input type="hidden" name="custtype" id="custtype" value="{$custtype}" />

            <br /><br />
				<div class="text-center" style="margin-top : 25px;">
                    <h1>Step 2 of 3 : Login to your account</h1>
                </div>

            <div style="float:left;width:20px;">&nbsp;</div><div class="signuptype{if !$loggedin && $custtype neq "existing"} active{/if}"{if !$loggedin} id="newcust"{/if}>{$LANG.newcustomer}</div><div class="signuptype{if $custtype eq "existing" && !$loggedin || $loggedin} active{/if}" id="existingcust">{$LANG.existingcustomer}</div>
            <div class="clear"></div>

            <div class="signupfields signupfields-existing{if $custtype eq "existing" && !$loggedin}{else} hidden{/if}" id="loginfrm">

                <div class="col-sm-6 col-sm-offset-3">

                    <div class="form-group">
                        <label for="inputEmail">{$LANG.clientareaemail}</label>
                        <input type="text" name="loginemail" class="form-control" id="inputEmail" placeholder="{$LANG.enteremail}"{if $loggedin} disabled{/if} />
                    </div>
                    <div class="form-group">
                        <label for="inputPassword">{$LANG.clientareapassword}</label>
                        <input type="password" name="loginpw" class="form-control" id="inputPassword" placeholder="{$LANG.clientareapassword}"{if $loggedin} disabled{/if} />
                    </div>

                </div>

                <div class="clearfix"></div>

            </div>
            <div class="signupfields{if $custtype eq "existing" && !$loggedin} hidden{/if}" id="signupfrm">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            {if $loggedin}
                                <div class="row">
                                    <label class="col-sm-4 text-right">
                                        {$LANG.clientareafirstname}
                                    </label>
                                    <div class="col-sm-8">
                                        {$clientsdetails.firstname}
                                    </div>
                                </div>
                            {else}
                                <label for="firstname" class="control-label">{$LANG.clientareafirstname}</label>
                                <input type="text" name="firstname" id="firstname" value="{$clientsdetails.firstname}" class="form-control"{if !in_array('firstname', $clientsProfileOptionalFields)} required{/if} />
                            {/if}
                        </div>
                        <div class="form-group">
                            {if $loggedin}
                                <div class="row">
                                    <label class="col-sm-4 text-right">
                                        {$LANG.clientarealastname}
                                    </label>
                                    <div class="col-sm-8">
                                        {$clientsdetails.lastname}
                                    </div>
                                </div>
                            {else}
                                <label for="lastname" class="control-label">{$LANG.clientarealastname}</label>
                                <input type="text" name="lastname" id="lastname" value="{$clientsdetails.lastname}" class="form-control"{if !in_array('lastname', $clientsProfileOptionalFields)} required{/if}  />
                            {/if}
                        </div>
                        <div class="form-group">
                            {if $loggedin}
                                <div class="row">
                                    <label class="col-sm-4 text-right">
                                        {$LANG.clientareacompanyname}
                                    </label>
                                    <div class="col-sm-8">
                                        {$clientsdetails.companyname}
                                    </div>
                                </div>
                            {else}
                                <label for="companyname" class="control-label">{$LANG.clientareacompanyname}</label>
                                <input type="text" name="companyname" id="companyname" value="{$clientsdetails.companyname}" class="form-control" />
                            {/if}
                        </div>
                        <div class="form-group">
                            {if $loggedin}
                                <div class="row">
                                    <label class="col-sm-4 text-right">
                                        {$LANG.clientareaemail}
                                    </label>
                                    <div class="col-sm-8">
                                        {$clientsdetails.email}
                                    </div>
                                </div>
                            {else}
                                <label for="email" class="control-label">{$LANG.clientareaemail}</label>
                                <input type="email" name="email" id="email" value="{$clientsdetails.email}" class="form-control" required/>
                            {/if}
                        </div>
                        {if !$loggedin}
                            <div id="newPassword1" class="form-group has-feedback">
                                <label for="inputNewPassword1" class="control-label">{$LANG.clientareapassword}</label>
                                <input type="password" class="form-control" id="inputNewPassword1" data-error-threshold="{$pwStrengthErrorThreshold}" data-warning-threshold="{$pwStrengthWarningThreshold}" name="password" value="{$password}" required/>
                                <span class="form-control-feedback glyphicon glyphicon-password"></span>
                                {include file="$template/includes/pwstrength.tpl"}
                            </div>
                            <div id="newPassword2" class="form-group has-feedback">
                                <label for="inputNewPassword2" class="control-label">{$LANG.clientareaconfirmpassword}</label>
                                <input type="password" class="form-control" id="inputNewPassword2" name="password2" value="{$password2}" required/>
                                <span class="form-control-feedback glyphicon glyphicon-password"></span>
                                <div id="inputNewPassword2Msg">
                                </div>
                            </div>
                        {/if}
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            {if $loggedin}
                                <div class="row">
                                    <label class="col-sm-4 text-right">
                                        {$LANG.clientareaaddress1}
                                    </label>
                                    <div class="col-sm-8">
                                        {$clientsdetails.address1}
                                    </div>
                                </div>
                            {else}
                                <label for="address1" class="control-label">{$LANG.clientareaaddress1}</label>
                                <input type="text" name="address1" id="address1" value="{$clientsdetails.address1}" class="form-control"{if !in_array('address1', $clientsProfileOptionalFields)} required{/if} />
                            {/if}
                        </div>
                        <div class="form-group">
                            {if $loggedin}
                                <div class="row">
                                    <label class="col-sm-4 text-right">
                                        {$LANG.clientareaaddress2}
                                    </label>
                                    <div class="col-sm-8">
                                        {$clientsdetails.address2}
                                    </div>
                                </div>
                            {else}
                                <label for="address2" class="control-label">{$LANG.clientareaaddress2}</label>
                                <input type="text" name="address2" id="address2" value="{$clientsdetails.address2}" class="form-control" />
                            {/if}
                        </div>
                        <div class="form-group">
                            {if $loggedin}
                                <div class="row">
                                    <label class="col-sm-4 text-right">
                                        {$LANG.clientareacity}
                                    </label>
                                    <div class="col-sm-8">
                                        {$clientsdetails.city}
                                    </div>
                                </div>
                            {else}
                                <label for="city" class="control-label">{$LANG.clientareacity}</label>
                                <input type="text" name="city" id="city" value="{$clientsdetails.city}" class="form-control"{if !in_array('city', $clientsProfileOptionalFields)} required{/if} />
                            {/if}
                        </div>
                        <div class="form-group">
                            {if $loggedin}
                                <div class="row">
                                    <label class="col-sm-4 text-right">
                                        {$LANG.clientareastate}
                                    </label>
                                    <div class="col-sm-8">
                                        {$clientsdetails.state}
                                    </div>
                                </div>
                            {else}
                                <label for="state" class="control-label">{$LANG.clientareastate}</label>
                                <input type="text" name="state" id="state" value="{$clientsdetails.state}" class="form-control"{if !in_array('state', $clientsProfileOptionalFields)} required{/if} />
                            {/if}
                        </div>
                        <div class="form-group">
                            {if $loggedin}
                                <div class="row">
                                    <label class="col-sm-4 text-right">
                                        {$LANG.clientareapostcode}
                                    </label>
                                    <div class="col-sm-8">
                                        {$clientsdetails.postcode}
                                    </div>
                                </div>
                            {else}
                                <label for="postcode" class="control-label">{$LANG.clientareapostcode}</label>
                                <input type="text" name="postcode" id="postcode" value="{$clientsdetails.postcode}" class="form-control"{if !in_array('postcode', $clientsProfileOptionalFields)} required{/if} />
                            {/if}
                        </div>
                        <div class="form-group">
                            {if $loggedin}
                                <div class="row">
                                    <label class="col-sm-4 text-right">
                                        {$LANG.clientareacountry}
                                    </label>
                                    <div class="col-sm-8">
                                        {$clientsdetails.country}
                                    </div>
                                </div>
                            {else}
                                <label for="country" class="control-label">{$LANG.clientareacountry}</label>
                                <select id="country" name="country" class="form-control">
                                    {foreach from=$countries key=thisCountryCode item=thisCountryName}
                                        <option value="{$thisCountryCode}" {if $thisCountryCode eq $clientsdetails.country}selected="selected"{/if}>{$thisCountryName}</option>
                                    {/foreach}
                                </select>
                            {/if}
                        </div>
                        <div class="form-group">
                            {if $loggedin}
                                <div class="row">
                                    <label class="col-sm-4 text-right">
                                        {$LANG.clientareaphonenumber}
                                    </label>
                                    <div class="col-sm-8">
                                        {$clientsdetails.phonenumber}
                                    </div>
                                </div>
                            {else}
                                <label for="phonenumber" class="control-label">{$LANG.clientareaphonenumber}</label>
                                <input type="text" name="phonenumber" id="phonenumber" value="{$clientsdetails.phonenumber}" class="form-control"{if !in_array('phonenumber', $clientsProfileOptionalFields)} required{/if} />
                            {/if}
                        </div>
                        {if $customfields}
                            {foreach from=$customfields key=num item=customfield}
                                <div class="form-group">
                                    <label class="control-label" for="customfield{$customfield.id}">{$customfield.name}</label>
                                    <div class="control">
                                        {$customfield.input} {$customfield.description}
                                    </div>
                                </div>
                            {/foreach}
                        {/if}
                    </div>
                </div>
            </div>

            {if $securityquestions && !$loggedin}
                <div class="panel panel-default" id="securityQuestion">
                    <div class="panel-heading">
                        <h3 class="panel-title">{$LANG.clientareasecurityquestion}:</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-group col-sm-12">
                            <select name="securityqid" id="securityqid" class="form-control">
                                {foreach key=num item=question from=$securityquestions}
                                    <option value={$question.id}>{$question.question}</option>
                                {/foreach}
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 control-label" for="securityqans">{$LANG.clientareasecurityanswer}</label>
                            <div class="col-sm-6">
                                <input type="password" name="securityqans" id="securityqans" class="form-control"/>
                            </div>
                        </div>
                    </div>
                </div>
            {/if}

            {if $taxenabled && !$loggedin}
                <div class="carttaxwarning">
                    {$LANG.carttaxupdateselections}
                    <input type="submit" value="{$LANG.carttaxupdateselectionsupdate}" name="updateonly" id="btnUpdateOnly" class="btn btn-info btn-sm" />
                </div>
            {/if}

            {if $domainsinorder}
                <h2>{$LANG.domainregistrantinfo}</h2>
                <select name="contact" id="inputDomainContact" class="form-control">
                    <option value="">{$LANG.usedefaultcontact}</option>
                    {foreach from=$domaincontacts item=domcontact}
                        <option value="{$domcontact.id}"{if $contact==$domcontact.id} selected{/if}>{$domcontact.name}</option>
                    {/foreach}
                    <option value="addingnew"{if $contact eq "addingnew"} selected{/if}>{$LANG.clientareanavaddcontact}...</option>
                </select>
                <br />
                <div class="signupfields{if $contact neq "addingnew"} hidden{/if}" id="domaincontactfields">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="domaincontactfirstname" class="control-label">{$LANG.clientareafirstname}</label>
                                <input type="text" name="domaincontactfirstname" id="domaincontactfirstname" value="{$domaincontact.firstname}" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="domaincontactlastname" class="control-label">{$LANG.clientarealastname}</label>
                                <input type="text" name="domaincontactlastname" id="domaincontactlastname" value="{$domaincontact.lastname}" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="domaincontactcompanyname" class="control-label">{$LANG.clientareacompanyname}</label>
                                <input type="text" name="domaincontactcompanyname" id="domaincontactcompanyname" value="{$domaincontact.companyname}" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="domaincontactemail" class="control-label">{$LANG.clientareaemail}</label>
                                <input type="email" name="domaincontactemail" id="domaincontactemail" value="{$domaincontact.email}" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="domaincontactphonenumber" class="control-label">{$LANG.clientareaphonenumber}</label>
                                <input type="text" name="domaincontactphonenumber" id="domaincontactphonenumber" value="{$domaincontact.phonenumber}" class="form-control" />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="domaincontactaddress1" class="control-label">{$LANG.clientareaaddress1}</label>
                                <input type="text" name="domaincontactaddress1" id="domaincontactaddress1" value="{$domaincontact.address1}" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="domaincontactaddress2" class="control-label">{$LANG.clientareaaddress2}</label>
                                <input type="text" name="domaincontactaddress2" id="domaincontactaddress2" value="{$domaincontact.address2}" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="domaincontactcity" class="control-label">{$LANG.clientareacity}</label>
                                <input type="text" name="domaincontactcity" id="domaincontactcity" value="{$domaincontact.city}" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="domaincontactstate" class="control-label">{$LANG.clientareastate}</label>
                                <input type="text" name="domaincontactstate" id="domaincontactstate" value="{$domaincontact.state}" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="domaincontactpostcode" class="control-label">{$LANG.clientareapostcode}</label>
                                <input type="text" name="domaincontactpostcode" id="domaincontactpostcode" value="{$domaincontact.postcode}" class="form-control" />
                            </div>
                            <div class="form-group">
                                <label for="domaincontactcountry" class="control-label">{$LANG.clientareacountry}</label>
                                <select id="domaincontactcountry" name="domaincontactcountry" class="form-control">
                                    {foreach from=$countries key=thisCountryCode item=thisCountryName}
                                        <option value="{$thisCountryCode}" {if ($domaincontact.country && $thisCountryCode eq $domaincontact.country) || $thisCountryCode eq $clientsdetails.country}selected="selected"{/if}>{$thisCountryName}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            {/if}
				<div class="text-center" style="margin-top : 25px;">
                    <h1>Step 3 of 3 : Proceed to checkout</h1>
                </div>
            <div class="row">
                <!--<div class="col-md-6">

                    <div class="signupfields padded">
                        <h2>{$LANG.orderpromotioncode}</h2>
                        {if $promotioncode}
                            {$promotioncode} - {$promotiondescription}<br />
                            <a href="{$smarty.server.PHP_SELF}?a=removepromo">{$LANG.orderdontusepromo}</a>
                        {else}
                            <div class="col-xs-10 col-xs-offset-1">
                                <div class="input-group">
                                    <input type="text" name="promocode" id="inputPromoCode" class="form-control" placeholder="{lang key="orderPromoCodePlaceholder"}">
                                    <span class="input-group-btn">
                                        <input type="hidden" name="validatepromo" id="validatepromo" value="0" />
                                        <button type="button" id="validatePromoCode" class="btn btn-warning">
                                            {$LANG.orderpromovalidatebutton}
                                        </button>
                                    </span>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        {/if}
                    </div>

                    {if $shownotesfield}
                        <div class="signupfields padded">
                            <h2>{$LANG.ordernotes}</h2>
                            <textarea name="notes" rows="3" class="form-control" placeholder="{$LANG.ordernotesdescription}">{$orderNotes}</textarea>
                        </div>
                    {/if}

                </div>-->
                <div class="col-md-12">

                    <div class="signupfields padded">
                        <h2>{$LANG.orderpaymentmethod}</h2>
                        {foreach key=num item=gateway from=$gateways}
                            <label class="radio-inline">
                                <input type="radio" name="paymentmethod" value="{$gateway.sysname}" id="pgbtn{$num}" onclick="{if $gateway.type eq "CC"}showCCForm(){else}hideCCForm(){/if}"{if $selectedgateway eq $gateway.sysname} checked{/if} />
                                {$gateway.name}
                            </label>
                        {/foreach}

                        <br /><br />
                        <div class="alert alert-danger text-center gateway-errors hidden"></div>

                        <div id="ccinputform" class="signupfields{if $selectedgatewaytype neq "CC"} hidden{/if}">
                            <table width="100%" cellspacing="0" cellpadding="0" class="configtable textleft">
                                {if $clientsdetails.cclastfour}
                                    <tr>
                                        <td class="fieldlabel"></td>
                                        <td class="fieldarea">
                                            <label class="radio-inline">
                                                <input type="radio" name="ccinfo" value="useexisting" id="useexisting" onclick="useExistingCC()"{if $clientsdetails.cclastfour} checked{else} disabled{/if} />
                                                {$LANG.creditcarduseexisting}
                                                {if $clientsdetails.cclastfour}
                                                    ({$clientsdetails.cclastfour})
                                                {/if}
                                            </label><br />
                                            <label class="radio-inline">
                                                <input type="radio" name="ccinfo" value="new" id="new" onclick="enterNewCC()"{if !$clientsdetails.cclastfour || $ccinfo eq "new"} checked{/if} />
                                                {$LANG.creditcardenternewcard}
                                            </label>
                                        </td>
                                    </tr>
                                {else}
                                    <input type="hidden" name="ccinfo" value="new" />
                                {/if}
                                <tr class="newccinfo"{if $clientsdetails.cclastfour && $ccinfo neq "new"} style="display:none;"{/if}>
                                    <td class="fieldlabel">{$LANG.creditcardcardtype}</td>
                                    <td class="fieldarea">
                                        <select name="cctype" id="cctype">
                                            {foreach key=num item=cardtype from=$acceptedcctypes}
                                                <option{if $cctype eq $cardtype} selected{/if}>{$cardtype}</option>
                                            {/foreach}
                                        </select>
                                    </td>
                                </tr>
                                <tr class="newccinfo"{if $clientsdetails.cclastfour && $ccinfo neq "new"} style="display:none;"{/if}>
                                    <td class="fieldlabel">{$LANG.creditcardcardnumber}</td>
                                    <td class="fieldarea">
                                        <input type="text" name="ccnumber" size="30" value="{$ccnumber}" autocomplete="off" />
                                    </td>
                                </tr>
                                <tr class="newccinfo"{if $clientsdetails.cclastfour && $ccinfo neq "new"} style="display:none;"{/if}>
                                    <td class="fieldlabel">{$LANG.creditcardcardexpires}</td>
                                    <td class="fieldarea">
                                        <select name="ccexpirymonth" id="ccexpirymonth" class="newccinfo">
                                            {foreach from=$months item=month}
                                                <option{if $ccexpirymonth eq $month} selected{/if}>{$month}</option>
                                            {/foreach}
                                        </select>
                                        /
                                        <select name="ccexpiryyear" class="newccinfo">
                                            {foreach from=$expiryyears item=year}
                                                <option{if $ccexpiryyear eq $year} selected{/if}>{$year}</option>
                                            {/foreach}
                                        </select>
                                    </td>
                                </tr>
                                {if $showccissuestart}
                                    <tr class="newccinfo"{if $clientsdetails.cclastfour && $ccinfo neq "new"} style="display:none;"{/if}>
                                        <td class="fieldlabel">{$LANG.creditcardcardstart}</td>
                                        <td class="fieldarea">
                                            <select name="ccstartmonth" id="ccstartmonth" class="newccinfo">
                                                {foreach from=$months item=month}
                                                    <option{if $ccstartmonth eq $month} selected{/if}>{$month}</option>
                                                {/foreach}
                                            </select>
                                            /
                                            <select name="ccstartyear" class="newccinfo">
                                                {foreach from=$startyears item=year}
                                                    <option{if $ccstartyear eq $year} selected{/if}>{$year}</option>
                                                {/foreach}
                                            </select>
                                        </td>
                                    </tr>
                                    <tr class="newccinfo"{if $clientsdetails.cclastfour && $ccinfo neq "new"} style="display:none;"{/if}>
                                        <td class="fieldlabel">{$LANG.creditcardcardissuenum}</td>
                                        <td class="fieldarea">
                                            <input type="text" name="ccissuenum" value="{$ccissuenum}" size="5" maxlength="3" />
                                        </td>
                                    </tr>
                                {/if}
                                <tr>
                                    <td class="fieldlabel">{$LANG.creditcardcvvnumber}</td>
                                    <td class="fieldarea">
                                        <input type="text" name="cccvv" id="cccvv" value="{$cccvv}" size="5" autocomplete="off" />
                                        <a href="#" onclick="window.open('{$BASE_PATH_IMG}/ccv.gif','','width=280,height=200,scrollbars=no,top=100,left=100');return false">{$LANG.creditcardcvvwhere}</a>
                                    </td>
                                </tr>
                                {if $shownostore}
                                    <tr>
                                        <td></td>
                                        <td class="fieldarea">
                                            <label class="checkbox-inline" for="nostore">
                                                <input type="checkbox" name="nostore" />
                                                {$LANG.creditcardnostore}
                                            </label>
                                        </td>
                                    </tr>
                                {/if}
                            </table>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>

            {if $accepttos}
                <div align="center">
                    <label class="checkbox-inline">
                        <input type="checkbox" name="accepttos" id="accepttos" />
                        {$LANG.ordertosagreement}
                        <a href="{$tosurl}" target="_blank">{$LANG.ordertos}</a>
                    </label>
                </div>
                <br />
            {/if}

            <div align="center">
                <button type="submit" id="btnCompleteOrder"{if $cartitems==0} disabled{/if} onclick="this.value='{$LANG.pleasewait}'" class="btn btn-primary btn-lg" {if $custtype eq "existing" && !$loggedin}formnovalidate{/if}>
                    {$LANG.checkout}
                    &nbsp;<i class="fa fa-arrow-circle-right"></i>
                </button>
            </div>

        </form>

    {else}

        <br /><br />

    {/if}

    <div class="cartwarningbox">
        <img src="assets/img/padlock.gif" align="absmiddle" border="0" alt="Secure Transaction" />
        &nbsp;{$LANG.ordersecure} (<strong>{$ipaddress}</strong>) {$LANG.ordersecure2}
    </div>

</div>
{include file="orderforms/$carttpl/footer.tpl"}