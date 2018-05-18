jQuery(document).ready(function () {
    jQuery("#existingcust").click(function () {
        if (jQuery(this).hasClass('active') != true) {
            jQuery(".signuptype").removeClass('active');
            jQuery(this).addClass('active');
            jQuery("#signupfrm").fadeToggle('fast', function () {
                jQuery("#securityQuestion").fadeToggle('fast');
                jQuery("#loginfrm").hide().removeClass('hidden').fadeToggle('fast');
                jQuery("#btnCompleteOrder").attr('formnovalidate', true);
            });
            jQuery("#custtype").val("existing");
        }
    });
    jQuery("#newcust").click(function () {
        if (jQuery(this).hasClass('active') != true) {
            jQuery(".signuptype").removeClass('active');
            jQuery(this).addClass('active');
            jQuery("#loginfrm").fadeToggle('fast', function () {
                jQuery("#securityQuestion").fadeToggle('fast');
                jQuery("#signupfrm").hide().removeClass('hidden').fadeToggle('fast');
                jQuery("#btnCompleteOrder").removeAttr('formnovalidate');
            });
            jQuery("#custtype").val("new");
        }
    });
    jQuery("#orderNote").click(function () {
        if (jQuery(this).hasClass('active') != true) {
            jQuery(".applyType").removeClass('active');
            jQuery(this).addClass('active');
            jQuery("#promotionCodeForm").fadeToggle('fast', function () {
                jQuery("#orderNoteForm").hide().removeClass('hidden').fadeToggle('fast');
            });
        }
    });
    jQuery("#promotionCode").click(function () {
        if (jQuery(this).hasClass('active') != true) {
            jQuery(".applyType").removeClass('active');
            jQuery(this).addClass('active');
            jQuery("#orderNoteForm").fadeToggle('fast', function () {
                jQuery("#promotionCodeForm").hide().removeClass('hidden').fadeToggle('fast');
            });
        }
    });


    jQuery("#inputDomainContact").on('change', function () {
        if (this.value == "addingnew") {
            jQuery("#domaincontactfields :input")
                    .not("#domaincontactaddress2, #domaincontactcompanyname")
                    .attr('required', true);
            jQuery("#domaincontactfields").hide().removeClass('hidden').slideDown();
        } else {
            jQuery("#domaincontactfields").slideUp();
            jQuery("#domaincontactfields :input").attr('required', false);
        }
    });

    jQuery(".configOptionDesc1 .expertSupport").click(function () {
        jQuery('html, body').animate({
            scrollTop: jQuery("#wesiteMonitor").offset().top
        }, 2000)
    });
    jQuery(".configOptionDesc1 .serverMonitoringPlan").click(function () {
        jQuery('html, body').animate({
            scrollTop: jQuery("#configProductDiv").offset().top
        }, 2000)
    });
    jQuery(".configOptionDesc1 .serverHealthMonitoring").click(function () {
        jQuery('html, body').animate({
            scrollTop: jQuery("#healthMonitor").offset().top
        }, 2000)
    });
    jQuery(".configOptionDesc1 .backupManagement").click(function () {
        jQuery('html, body').animate({
            scrollTop: jQuery("#backupMngmnt").offset().top
        }, 2000)
    });
    jQuery(".configOptionDesc1 .healthMonitor").click(function () {
        jQuery('html, body').animate({
            scrollTop: jQuery("#configOptionDescMain").offset().top
        }, 2000)
    });

    jQuery(document).on("click", '#cycle1', monthlyBillingCycle);
    jQuery(document).on("click", '#cycle4', annualBillingCycle);

    /*Monthly billing cycle is selected*/
    if (jQuery('#cycle1').prop('checked') === true) {
        monthlyBillingCycle();
    }
    /*Annual billing cycle is selected*/
    if (jQuery('#cycle4').prop('checked') === true) {
        annualBillingCycle();
    }

    /**
     * Function for monthly billing cycle activation
     * @returns {undefined}
     */

    function monthlyBillingCycle() {
        jQuery('.mainProDivAnnually').next().find('.configRadioInlineInp').prop('checked', false);
        jQuery('.mainProDivMonthly').next().find('.configRadioInlineInp').prop('checked', false);

        jQuery('.mainProDivMonthly').parents('.optionTwo').css('display', 'block');
        jQuery('.mainProDivMonthly').next().find('.configRadioInlineInp').first().prop('checked', true);

        jQuery('.mainProDivAnnually').parents('.optionTwo').css('display', 'none');
        jQuery('.mainProDivAnnually').next().find('.configRadioInlineInp').last().prop('checked', true);
        recalctotals();
    }

    /**
     * Function for annual billing cycle activation
     * @returns {undefined}
     */
    function annualBillingCycle() {
        jQuery('.mainProDivAnnually').next().find('.configRadioInlineInp').prop('checked', false);
        jQuery('.mainProDivMonthly').next().find('.configRadioInlineInp').prop('checked', false);

        jQuery('.mainProDivAnnually').parents('.optionTwo').css('display', 'block');
        jQuery('.mainProDivAnnually').next().find('.configRadioInlineInp').first().prop('checked', true);

        jQuery('.mainProDivMonthly').parents('.optionTwo').css('display', 'none');
        jQuery('.mainProDivMonthly').next().find('.configRadioInlineInp').last().prop('checked', true);
        recalctotals();
    }

});

function showcats() {
    jQuery("#categories").slideToggle();
}

function selproduct(num) {
    jQuery('#productslider').slider("value", num);
    jQuery(".product").hide();
    jQuery("#product" + num).show();
    jQuery(".sliderlabel").removeClass("selected");
    jQuery("#prodlabel" + num).addClass("selected");
}

function recalctotals(hideLoading) {
    if (typeof hideLoading === 'undefined') {
        hideLoading = true;
    }
    if (!jQuery("#cartLoader").is(":visible")) {
        jQuery("#cartLoader").fadeIn('fast');
    }
    var post = jQuery.post("cart.php", 'ajax=1&a=confproduct&calctotal=true&' + jQuery("#orderfrm").serialize());
    post.done(
            function (data) {
                jQuery("#producttotal").html(data);
            }
    );
    if (hideLoading) {
        post.always(
                function () {
                    jQuery("#cartLoader").delay(500).fadeOut('slow');
                }
        );
    }
}

function addtocart(gid) {
    jQuery("#loading1").slideDown();
    jQuery.post("cart.php", 'ajax=1&a=confproduct&' + jQuery("#orderfrm").serialize(),
            function (data) {
                if (data) {
                    jQuery("#configproducterror").html(data);
                    jQuery("#configproducterror").slideDown();
                    jQuery("#loading1").slideUp();
                } else {
                    if (gid)
                        window.location = 'cart.php?gid=' + gid;
                    else
                        window.location = 'cart.php?a=confdomains';
                }
            });
}

function showCCForm() {
    if (!jQuery("#ccinputform").is(":visible")) {
        jQuery("#ccinputform").hide().removeClass('hidden').slideDown();
    }
}
function hideCCForm() {
    jQuery("#ccinputform").slideUp();
}
function useExistingCC() {
    jQuery(".newccinfo").hide();
}
function enterNewCC() {
    jQuery(".newccinfo").removeClass('hidden').show();
}

function updateConfigurableOptions(i, billingCycle) {
    jQuery("#cartLoader").fadeIn('fast');
    var post = jQuery.post(
            "cart.php",
            'a=cyclechange&ajax=1&i=' + i + '&billingcycle=' + billingCycle
            );

    post.done(
            function (data) {
                if (data == '') {
                    window.location = 'cart.php?a=view';
                } else {
                    jQuery("#prodconfigcontainer").replaceWith(data);
                    jQuery("#prodconfigcontainer").slideDown();
                    recalctotals(false);
                }
            }
    );

    post.always(
            function () {
                jQuery("#cartLoader").delay(500).fadeOut('slow');
            }

    );
}

function catchEnter(e) {
    if (e) {
        addtocart();
        e.returnValue = false;
    }
}


$(function(){
	if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
 		// some code..
	} else {
	$(window).scroll(function(e){
		var scroll = $(window).scrollTop();
		var inrespectto = $('.product-div');
		var toped = inrespectto.offset().top;
		var totaltoped = inrespectto.height();

		$("#os-div-float").css({top: 0, position:'relative'});
		
		if(scroll > toped ) {
			$("#os-div-float").css({top: 0, position:'fixed'});
		}
		
		if(scroll > parseInt(totaltoped - ($("#os-div-float").height()/2))) {
			$("#os-div-float").css({top: parseInt(totaltoped - parseInt($("#os-div-float").height() + 70)), position:'relative'});
		}
		
	});
	
	$("#os-div-float").css({top: 0, position:'relative'});
	//console.log($('.product-div').height());
	}
})