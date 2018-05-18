

{if $producttotals.billingcycle eq 'monthly'}
	{assign var="billingcycle" value="1 Month"}
	{assign var="billingcyclenumeric" value="1"}
{/if}
{if $producttotals.billingcycle eq 'quarterly'}
	{assign var="billingcycle" value="3 Months"}
	{assign var="billingcyclenumeric" value="3"}
{/if}
{if $producttotals.billingcycle eq 'semiannually'}
	{assign var="billingcycle" value="6 Months"}
	{assign var="billingcyclenumeric" value="6"}
{/if}
{if $producttotals.billingcycle eq 'annually'}
	{assign var="billingcycle" value="12 Months"}
	{assign var="billingcyclenumeric" value="12"}
{/if}
{if $producttotals.billingcycle eq 'biennially'}
	{assign var="billingcycle" value="24 Months"}
	{assign var="billingcyclenumeric" value="24"}
{/if}
{if $producttotals.billingcycle eq 'triennially'}
	{assign var="billingcycle" value="36 Months"}
	{assign var="billingcyclenumeric" value="36"}
{/if}
<table class="ordersummarytbl">
	<tbody>
    	<tr style="display:none">
        </tr>
    	<tr class="orderData">
        	<td id="orderSummaryItem">{$producttotals.productinfo.name}</td>
            <td class="text-right" style="text-align: right;">{$producttotals.pricing.baseprice|replace:$currency.code:''}</td>
        </tr>
        <tr class="orderPeriod">
          <td>{if $billingcyclenumeric > 1}{$currency.prefix}{(($producttotals.pricing.baseprice|replace:$currency.code:''|replace:$currency.prefix:'')/$billingcyclenumeric)|number_format:2}/month{/if}</td>
          <td>{$billingcycle}</td>
        </tr>
    {foreach from=$producttotals.configoptions item=configoption}
    	{if $configoption}
        	{if ($configoption.recurring|replace:$currency.code:''|replace:$currency.prefix:'') > 0}
            <tr class="orderData">
                <td id="orderSummaryItem">{$configoption.name}: {$configoption.optionname}</td>
                <td class="text-right" style="text-align: right;">{$configoption.recurring|replace:$currency.code:''}</td>
            </tr>
            <tr class="orderPeriod">
              <td>{if $billingcyclenumeric > 1}{$currency.prefix}{(($configoption.recurring|replace:$currency.code:''|replace:$currency.prefix:'')/$billingcyclenumeric)|number_format:2}/month{/if}</td>
              <td>{$billingcycle}</td>
            </tr>
            {/if}
    	{/if}
    {/foreach}
    {foreach from=$producttotals.addons item=addon}
    	<tr class="orderData">
        	<td id="orderSummaryItem">+ {$addon.name}</td>
            <td class="text-right" style="text-align: right;">{$addon.recurring}</td>
        </tr>
    {/foreach}        
        
        <tr style="display:none"></tr>
        <tr style="display:none"></tr>
        <tr style="display:none"></tr>
    </tbody>
</table>
<div class="summaryproduct"></div>
<div></div>
<table width="100%" class="order-total">
        <tbody><tr>
        <td colspan="2" class="text-left">Total: </td>
        <td class="orderTotal">{$producttotals.pricing.totaltoday}</td>
    </tr>
</tbody></table>
<!--
<div class="summaryproduct">{$producttotals.productinfo.groupname} - <b>{$producttotals.productinfo.name}</b></div>
<table class="ordersummarytbl">
<tr><td>{$producttotals.productinfo.name}</td><td class="text-right">{$producttotals.pricing.baseprice}</td></tr>
{foreach from=$producttotals.configoptions item=configoption}{if $configoption}
<tr><td style="padding-left:10px;">&raquo; {$configoption.name}: {$configoption.optionname}</td><td class="text-right">{$configoption.recurring}{if $configoption.setup} + {$configoption.setup} {$LANG.ordersetupfee}{/if}</td></tr>
{/if}{/foreach}
{foreach from=$producttotals.addons item=addon}
<tr><td>+ {$addon.name}</td><td class="text-right">{$addon.recurring}</td></tr>
{/foreach}
</table>
{if $producttotals.pricing.setup || $producttotals.pricing.recurring || $producttotals.pricing.addons}
<div class="summaryproduct"></div>
<table width="100%">
{if $producttotals.pricing.setup}<tr><td>{$LANG.cartsetupfees}:</td><td class="text-right">{$producttotals.pricing.setup}</td></tr>{/if}
{foreach from=$producttotals.pricing.recurringexcltax key=cycle item=recurring}
<tr><td>{$cycle}:</td><td class="text-right">{$recurring}</td></tr>
{/foreach}
{if $producttotals.pricing.tax1}<tr><td>{$carttotals.taxname} @ {$carttotals.taxrate}%:</td><td class="text-right">{$producttotals.pricing.tax1}</td></tr>{/if}
{if $producttotals.pricing.tax2}<tr><td>{$carttotals.taxname2} @ {$carttotals.taxrate2}%:</td><td class="text-right">{$producttotals.pricing.tax2}</td></tr>{/if}
</table>
{/if}
<div class="summaryproduct"></div>
<table width="100%">
<tr><td colspan="2" class="text-right">{$LANG.ordertotalduetoday}: <b>{$producttotals.pricing.totaltoday}</b></td></tr>
</table>-->
