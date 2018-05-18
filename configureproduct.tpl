<div id="prodconfigcontainer" >
{include file="orderforms/$carttpl/header.tpl"}
<script type="text/javascript" src="{$BASE_PATH_JS}/jquery-ui.min.js"></script>
<script type="text/javascript" src="templates/orderforms/{$carttpl}/js/main.js"></script>
<link rel="stylesheet" type="text/css" href="templates/orderforms/{$carttpl}/style.css" />
<link rel="stylesheet" type="text/css" href="{$BASE_PATH_CSS}/jquery-ui.min.css" />


 <!--Added js for tooltip on click action -->
    
        <script>
            /*
             Function to redired to contactus page ref #104547
             */
           /* function bulkRedirect() {
            window.open("https://sysally.com/contact-us/");
            }*/

            jQuery(function () {

				/*Function to perform action on clickind div tooltipBob*/
				jQuery('.tooltipBob').mouseover(function () {
					jQuery('span', this).show();
				});
				/*Function to hide the tooltip comment on mouseout event*/
				jQuery(".tooltipBob").mouseout(function () {
					jQuery(".tooltiptext").hide();
				});
            /*for elimination the text in bracket for product heading*/
				$(document).ready(function () {
					$(".configOptionName").each(function (element) {
						var str = $(this).text().replace(/ *\([^)]*\) */g, "");
						$(this).text(str);
					});
				});
            });
        </script>

<div id="order-modern" class="container-fluid">
{if $smarty.get.billing }
    {$billingcycle = $smarty.get.billing}
{/if}

<form id="orderfrm" onsubmit="catchEnter(event);">

<input type="hidden" name="configure" value="true" />
<input type="hidden" name="i" value="{$i}" />

{if !$firstconfig || $firstconfig && !$domain}
    <div class="title-bar">
        <h1>CUSTOMIZE YOUR ORDER</h1>
    </div>
{/if}

<div id="configproducterror" class="errorbox"></div>

<div class="row bobServerRow" >
<div class="product-div col-md-12">

{if $pricing.type eq "recurring"}

<div class="billingcycle">
<h3>{$LANG.cartchoosecycle}</h3>
<p class="configOptionDesc">Save money with annual billing.</p>
<table width="100%" cellspacing="0" cellpadding="0" class="configtable">
        <tr>
            <td class="fieldarea">
                {if $pricing.monthly}
                            <label for="cycle1" class="radio-inline configRadioInline">
                            	<input class="configRadioInlineInp" type="radio" name="billingcycle" id="cycle1" value="monthly"{if $billingcycle eq "monthly"} checked{/if} onclick="{if $configurableoptions}updateConfigurableOptions({$i}, this.value){else}recalctotals(){/if}" />
                                  <span>1 Month</span>
                                  <span class="configOptionPrice hidden-xs">{$currency.prefix}{$pricing.rawpricing.monthly}/month</span>
                            </label>
                {/if}
                {if $pricing.quarterly}
                            <label for="cycle2" class="radio-inline configRadioInline">
                                <input class="configRadioInlineInp" type="radio" name="billingcycle" id="cycle2" value="quarterly"{if $billingcycle eq "quarterly"} checked{/if} onclick="{if $configurableoptions}updateConfigurableOptions({$i}, this.value){else}recalctotals(){/if}" />
                                  <span>3 Months</span>
                                  <span class="configOptionPrice hidden-xs">{$currency.prefix}{($pricing.rawpricing.quarterly/3)|number_format:2}/month</span>
                                  <span class="strikeDisc hidden-xs">{$currency.prefix}{$pricing.rawpricing.monthly}/month</span>
                                  <span class="discPerc hidden-xs">Save {math equation="floor(((x-(y/z))*100)/x)" x=$pricing.rawpricing.monthly y=$pricing.rawpricing.quarterly z=3}%</span>
                            </label>
                        
                {/if}
                {if $pricing.semiannually}
                           <label for="cycle3" class="radio-inline configRadioInline">
                                <input class="configRadioInlineInp" type="radio" name="billingcycle" id="cycle3" value="semiannually"{if $billingcycle eq "semiannually"} checked{/if} onclick="{if $configurableoptions}updateConfigurableOptions({$i}, this.value){else}recalctotals(){/if}" />
                                   <span>6 Months</span>
                                   <span class="configOptionPrice hidden-xs">{$currency.prefix}{($pricing.rawpricing.semiannually/6)|number_format:2}/month</span>
                                   <span class="strikeDisc hidden-xs">{$currency.prefix}{$pricing.rawpricing.monthly}/month</span>
                                   <span class="discPerc hidden-xs">Save {math equation="floor(((x-(y/z))*100)/x)" x=$pricing.rawpricing.monthly y=$pricing.rawpricing.semiannually z=6}%</span>
                           </label>
                {/if}
                {if $pricing.annually}
                           <label for="cycle4" class="radio-inline configRadioInline">
                                <input class="configRadioInlineInp" type="radio" name="billingcycle" id="cycle4" value="annually"{if $billingcycle eq "annually"} checked{/if} onclick="{if $configurableoptions}updateConfigurableOptions({$i}, this.value){else}recalctotals(){/if}" />
                                   <span>1 Year</span>
                                   <span class="configOptionPrice hidden-xs">{$currency.prefix}{($pricing.rawpricing.annually/12)|number_format:2}/month</span>
                                   <span class="strikeDisc hidden-xs">{$currency.prefix}{$pricing.rawpricing.monthly}/month</span>
                                   <span class="discPerc hidden-xs">Save {math equation="floor(((x-(y/z))*100)/x)" x=$pricing.rawpricing.monthly y=$pricing.rawpricing.annually z=12}%</span>
                           </label>
                {/if}
                {if $pricing.biennially}
                           <label for="cycle5" class="radio-inline configRadioInline">
                                <input class="configRadioInlineInp" type="radio" name="billingcycle" id="cycle5" value="biennially"{if $billingcycle eq "biennially"} checked{/if} onclick="{if $configurableoptions}updateConfigurableOptions({$i}, this.value){else}recalctotals(){/if}" />
                                   <span>2 Years</span>
                                   <span class="configOptionPrice hidden-xs">{$currency.prefix}{($pricing.rawpricing.biennially/24)|number_format:2}/month</span>
                                   <span class="strikeDisc hidden-xs">{$currency.prefix}{$pricing.rawpricing.monthly}/month</span>
                                   <span class="discPerc hidden-xs">Save {math equation="floor(((x-(y/z))*100)/x)" x=$pricing.rawpricing.monthly y=$pricing.rawpricing.biennially z=24}%</span>
                           </label>
                {/if}
                {if $pricing.triennially}
                           <label for="cycle6" class="radio-inline configRadioInline">
                                <input class="configRadioInlineInp" type="radio" name="billingcycle" id="cycle6" value="triennially"{if $billingcycle eq "triennially"} checked{/if} onclick="{if $configurableoptions}updateConfigurableOptions({$i}, this.value){else}recalctotals(){/if}" />
                                   <span>3 Years</span>
                                   <span class="configOptionPrice hidden-xs">{$currency.prefix}{($pricing.rawpricing.triennially/36)|number_format:2}/month</span>
                                   <span class="strikeDisc hidden-xs">{$currency.prefix}{$pricing.rawpricing.monthly}/month</span>
                                   <span class="discPerc hidden-xs">Save {math equation="floor(((x-(y/z))*100)/x)" x=$pricing.rawpricing.monthly y=$pricing.rawpricing.triennially z=36}%</span>
                           </label>
                {/if}
            </td>
        </tr>
</table>
</div>
{/if}

{if $productinfo.type eq "server"}
<div class="serverconfig">
<h3>{$LANG.cartconfigserver}</h3>
<table width="100%" cellspacing="0" cellpadding="0" class="configtable">
<tr><td class="fieldlabel">{$LANG.serverhostname}:</td><td class="fieldarea"><input type="text" name="hostname" size="15" value="{$server.hostname}" /> {$LANG.serverhostnameexample}</td></tr>
<tr><td class="fieldlabel">{$LANG.serverns1prefix}:</td><td class="fieldarea"><input type="text" name="ns1prefix" size="10" value="{$server.ns1prefix}" /> {$LANG.serverns1prefixexample}</td></tr>
<tr><td class="fieldlabel">{$LANG.serverns2prefix}:</td><td class="fieldarea"><input type="text" name="ns2prefix" size="10" value="{$server.ns2prefix}" /> {$LANG.serverns2prefixexample}</td></tr>
<tr><td class="fieldlabel">{$LANG.serverrootpw}:</td><td class="fieldarea"><input type="password" name="rootpw" size="20" value="{$server.rootpw}" /></td></tr>
</table>
</div>
{/if}
{if $configurableoptions}
    <div class="configoptions">
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="configtable">
            {foreach from=$configurableoptions item=configoption}
            
                {if $configoption.optiontype eq 1}
                	<tr class="optionOne" {if $configoption.hidden eq 1 } style="display:none;" {/if}>
                        <td>
                        	<div id="configProductDiv" class="configProductDiv">
                            	<div id="healthMonitor" class="fieldlabel configOptionName">{$configoption.optionname}</div>
                                 <div class="configOptionDesc">
                                    Our server experts monitor 5 vital signs that can affect server performance, and fix resource bottlenecks if an issue is found.
                    				<div class="tooltipBob">&nbsp;&nbsp;
                                        <span class="srvMngLearnMor">Learn more</span>
                                        <span class="tooltiptext" style="display: none;">
                                            We'll monitor server load, CPU usage, memory usage, disk I/O and swap space usage to make sure your server is functioning within optimal usage limits. If we see an abnormal spike in usage, a server administrator logs in to the server, looks for resource bottlenecks, and resolves the issue before it can cause a server downtime.
                                        </span>
                                    </div>
                                </div>
                                <h3>Add Server health monitoring</h3>
                                
                                <div class="fieldarea">
                                    <select name="configoption[{$configoption.id}]" onchange="recalctotals()" class="form-control">
                                        {foreach key=num2 item=options from=$configoption.options}
                                        
                                        {if $billingcycle eq 'monthly'}
                                            <option value="{$options.id}"{if $configoption.selectedvalue eq $options.id} selected="selected"{/if}>{$options.nameonly} {if $options.recurring > 0} {$currency.prefix}{$options.recurring}/month {/if}</option>
                                        {/if}
                                        {if $billingcycle eq 'quarterly'}
                                            <option value="{$options.id}"{if $configoption.selectedvalue eq $options.id} selected="selected"{/if}>{$options.nameonly} {if $options.recurring > 0} {$currency.prefix}{($options.recurring/3)|number_format:2}/month {/if}</option>
                                        {/if}
                                        {if $billingcycle eq 'semiannually'}
                                            <option value="{$options.id}"{if $configoption.selectedvalue eq $options.id} selected="selected"{/if}>{$options.nameonly} {if $options.recurring > 0} {$currency.prefix}{($options.recurring/6)|number_format:2}/month {/if}</option>
                                        {/if}
                                        {if $billingcycle eq 'annually'}
                                            <option value="{$options.id}"{if $configoption.selectedvalue eq $options.id} selected="selected"{/if}>{$options.nameonly} {if $options.recurring > 0} {$currency.prefix}{($options.recurring/12)|number_format:2}/month {/if}</option>
                                        {/if}
                                        {if $billingcycle eq 'biennially'}
                                            <option value="{$options.id}"{if $configoption.selectedvalue eq $options.id} selected="selected"{/if}>{$options.nameonly} {if $options.recurring > 0} {$currency.prefix}{($options.recurring/24)|number_format:2}/month {/if}</option>
                                        {/if}
                                        {if $billingcycle eq 'triennially'}
                                            <option value="{$options.id}"{if $configoption.selectedvalue eq $options.id} selected="selected"{/if}>{$options.nameonly} {if $options.recurring > 0} {$currency.prefix}{($options.recurring/36)|number_format:2}/month {/if}</option>
                                        {/if}
                                        {/foreach}
                                    </select>
                                    <span class="smContactUs">Need monitoring for more than 5 servers? <a href="https://sysally.com/contact-us/">Contact us</a> for bulk pricing</span>
                                </div>
                        	</div>
                        </td>
                    </tr>
                    <tr class="spacetr"></tr>
                {elseif $configoption.optiontype eq 2}
                	<tr class="optionTwo" {if $configoption.hidden eq 1 } style="display:none;" {/if}>
                    	<td>
                        
                            <div id="configProductDiv" class="configProductDiv">
                                <div class="mainProDiv mainProDivMonthly">
                                    <h3 class="configProName">{$configoption.optionname}</h3>
                                    <div class="configOptionDesc">
                                         We've added one server into this plan. Add more servers here:
                                    </div>
                                </div>
                                <div class="fieldarea">
                                
                                	
                                {foreach key=num2 item=options from=$configoption.options}
                                	<label class="radio-inline configRadioInline">
                                    <input class="configRadioInlineInp" type="radio" name="configoption[{$configoption.id}]" value="{$options.id}" {if $configoption.selectedvalue eq $options.id} checked="checked" {/if} onclick="recalctotals()" /> 
                                    <span>{$options.nameonly}</span>
                                    {if $options.recurring > 0}
                                        {if $billingcycle eq 'monthly'}
                                            <span class="configOptionPrice hidden-xs">{$currency.prefix}{$options.recurring}/month</span>
                                        {/if}
                                        {if $billingcycle eq 'quarterly'}
                                            <span class="configOptionPrice hidden-xs">{$currency.prefix}{($options.recurring/3)|number_format:2}/month</span>
                                        {/if}
                                        {if $billingcycle eq 'semiannually'}
                                            <span class="configOptionPrice hidden-xs">{$currency.prefix}{($options.recurring/6)|number_format:2}/month</span>
                                        {/if}
                                        {if $billingcycle eq 'annually'}
                                            <span class="configOptionPrice hidden-xs">{$currency.prefix}{($options.recurring/12)|number_format:2}/month</span>
                                        {/if}
                                        {if $billingcycle eq 'biennially'}
                                            <span class="configOptionPrice hidden-xs">{$currency.prefix}{($options.recurring/24)|number_format:2}/month</span>
                                        {/if}
                                        {if $billingcycle eq 'triennially'}
                                            <span class="configOptionPrice hidden-xs">{$currency.prefix}{($options.recurring/36)|number_format:2}/month</span>
                                        {/if}
                                    {/if}
                                    </label><br />
                            	{/foreach}
                                
                                </div>
                            </div>
                        
                        </td>
                    </tr>
                {elseif $configoption.optiontype eq 3}
                	<tr class="optionThree" {if $configoption.hidden eq 1 } style="display:none;" {/if}>
                    	<td class="fieldlabel">{$configoption.optionname}</td>
                        <td class="fieldarea">
      	                        <label class="checkbox-inline"><input type="checkbox" name="configoption[{$configoption.id}]" value="1"{if $configoption.selectedqty} checked{/if} onclick="recalctotals()" /> {$configoption.options.0.name}</label>
                        </td>
                    </tr>
                {elseif $configoption.optiontype eq 4}
                	<tr class="optionFour" {if $configoption.hidden eq 1 } style="display:none;" {/if}>
                    	<td class="fieldlabel">{$configoption.optionname}</td>
                        <td class="fieldarea">
                        
 						{if $configoption.qtymaximum}
                            {literal}
                                <script>
                                jQuery(function() {
                                    {/literal}
                                    var configid = '{$configoption.id}';
                                    var configmin = {$configoption.qtyminimum};
                                    var configmax = {$configoption.qtymaximum};
                                    var configval = {if $configoption.selectedqty}{$configoption.selectedqty}{else}{$configoption.qtyminimum}{/if};
                                    {literal}
                                    jQuery("#slider"+configid).slider({
                                        min: configmin,
                                        max: configmax,
                                        value: configval,
                                        range: "min",
                                        slide: function( event, ui ) {
                                            jQuery("#confop"+configid).val( ui.value );
                                            jQuery("#confoplabel"+configid).html( ui.value );
                                        },
                                        stop: function( event, ui ) {
                                            recalctotals();
                                        }
                                    });
                                });
                                </script>
                            {/literal}
                            <table width="90%">
                                <tr>
                                    <td width="30" id="confoplabel{$configoption.id}" class="configoplabel">{if $configoption.selectedqty}{$configoption.selectedqty}{else}{$configoption.qtyminimum}{/if}</td>
                                    <td><div id="slider{$configoption.id}"></div></td>
                                </tr>
                            </table>
                            <input type="hidden" name="configoption[{$configoption.id}]" id="confop{$configoption.id}" value="{if $configoption.selectedqty}{$configoption.selectedqty}{else}{$configoption.qtyminimum}{/if}" />
                        {else}
                            <input type="text" name="configoption[{$configoption.id}]" value="{$configoption.selectedqty}" size="5" onkeyup="recalctotals()" class="form-control" /> x {$configoption.options.0.name}
                        {/if}                        
                        
                        </td>
                    </tr>
                {/if}
            
            
            {/foreach}
        </table>
    </div>
{/if}

{if $addons}
<h3>{$LANG.cartavailableaddons}</h3>
<div class="addons">
<table width="100%" cellspacing="0" cellpadding="0" class="configtable">
{foreach from=$addons item=addon}
<tr><td class="radiofield"><input type="checkbox" name="addons[{$addon.id}]" id="a{$addon.id}"{if $addon.status} checked{/if} onclick="recalctotals()" /></td><td class="fieldarea"><label for="a{$addon.id}" class="checkbox-inline"><strong>{$addon.name}</strong> - {$addon.pricing}<br />{$addon.description}</label></td></tr>
{/foreach}
</table>
</div>
{/if}

{if $customfields}
<h3>{$LANG.orderadditionalrequiredinfo}</h3>
<div class="customfields">
<table width="100%" cellspacing="0" cellpadding="0" class="configtable">
{foreach key=num item=customfield from=$customfields}
<tr><td class="fieldlabel">{$customfield.name}</td><td class="fieldarea">{$customfield.input} {$customfield.description}</td></tr>
{/foreach}
</table>
</div>
{/if}

</div>
<!--<div class="col-md-4">-->
<div class="os-div">
    <div id="os-div-float">
    	<div>
            <div id="cartLoader" class="pull-right">
                <i class="fa fa-fw fa-refresh fa-spin"></i>
            </div>
            <div class="order-summary-head">
                <h3>{$LANG.ordersummary}</h3>
            </div>
        </div>
	    <div class="ordersummary" id="producttotal"></div>
    </div>
</div>

<div class="continue-cart">
    <div class="continueButton">
        <button type="button" id="btnCompleteProductConfig" class="btn btn-primary btn-lg" onclick="addtocart();">{$LANG.continue} &nbsp;<i class="fa fa-arrow-circle-right"></i></button>
    </div>
</div>


</div>

<script>recalctotals();</script>

</form>

</div>
{include file="orderforms/$carttpl/footer.tpl"}
</div>