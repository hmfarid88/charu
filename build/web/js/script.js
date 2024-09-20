
        $(document).ready(function () {
            $("#convyarea").hide();
            $("#chek").on('change', (function () {
                $("#convyarea").toggle();
            }));
       });
  
        $(document).ready(function () {
            $('#bankitem').hide();
            $('input[type=radio]').change(function () {
                if ($('#facbnk').is(':checked')) {
                    $('#bankitem').show();
                    document.getElementById("fpaybank").required = true;
                } else {
                    $('#bankitem').hide();
                    document.getElementById("fpaybank").required = false;
                }
            });
        });
   
        $(document).ready(function () {
            $('#bankitemforcost').hide();
            $('input[type=radio]').change(function () {
                if ($('#costbnk').is(':checked')) {
                    $('#bankitemforcost').show();
                    document.getElementById("costbank").required = true;
                } else {
                    $('#bankitemforcost').hide();
                    document.getElementById("costbank").required = false;
                }
            });
        });
    
        $(document).ready(function () {
            $('#bankrow').hide();
            $('input[type=radio]').change(function () {
                if ($('#bnk').is(':checked')) {
                    $('#bankrow').show();
                    document.getElementById("rtpbank").required = true;
                } else {
                    $('#bankrow').hide();
                    document.getElementById("rtpbank").required = false;
                }
            });
        });
         $(document).ready(function () {
            $('#banktport').hide();
            $('input[type=radio]').change(function () {
                if ($('#tport').is(':checked')) {
                    $('#banktport').show();
                    document.getElementById("tportbankpay").required = true;
                } else {
                    $('#banktport').hide();
                    document.getElementById("tportbankpay").required = false;
                }
            });
        });
         $(document).ready(function () {
            $('#bankexp').hide();
            $('input[type=radio]').change(function () {
                if ($('#exp').is(':checked')) {
                    $('#bankexp').show();
                    document.getElementById("expbank").required = true;
                } else {
                    $('#bankexp').hide();
                    document.getElementById("expbank").required = false;
                }
            });
        });
             
            function myFunction() {
            
                if ($('#payment').is(':selected')) {
                     $('#paytype').show();
                }else{
                     $('#paytype').hide();
                 }
        }
        
         $(document).ready(function () {
           $('#paytype').hide();
             $('#bankpcost').hide();
            $('input[type=radio]').change(function () {
                
                           if ($('#pcostbnk').is(':checked')) {
                    $('#bankpcost').show();
                    document.getElementById("costpbank").required = true;
                } else {
                    $('#bankpcost').hide();
                    document.getElementById("costpbank").required = false;
                }
            });
        });
   
        $(document).ready(function () {
            $("#lout").click(function () {

                if (confirm("Are you sure to logout?"))
                    document.forms[0].submit();
                else
                    return false;
            });
        });
   


