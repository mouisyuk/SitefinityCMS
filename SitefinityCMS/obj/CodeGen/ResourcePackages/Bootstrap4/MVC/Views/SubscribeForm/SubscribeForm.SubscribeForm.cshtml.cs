#pragma warning disable 1591
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SitefinityCMS.ResourcePackages.Bootstrap4.MVC.Views.SubscribeForm
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Net;
    using System.Text;
    using System.Web;
    using System.Web.Helpers;
    using System.Web.Mvc;
    using System.Web.Mvc.Ajax;
    using System.Web.Mvc.Html;
    using System.Web.Routing;
    using System.Web.Security;
    using System.Web.UI;
    using System.Web.WebPages;
    
    #line 4 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
    using Telerik.Sitefinity.Frontend.Mvc.Helpers;
    
    #line default
    #line hidden
    
    #line 5 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
    using Telerik.Sitefinity.Modules.Pages;
    
    #line default
    #line hidden
    
    #line 6 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
    using Telerik.Sitefinity.Services;
    
    #line default
    #line hidden
    
    #line 3 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
    using Telerik.Sitefinity.UI.MVC;
    
    #line default
    #line hidden
    
    #line 7 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
    using Telerik.Sitefinity.Web.Utilities;
    
    #line default
    #line hidden
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("RazorGenerator", "2.0.0.0")]
    [System.Web.WebPages.PageVirtualPathAttribute("~/ResourcePackages/Bootstrap4/MVC/Views/SubscribeForm/SubscribeForm.SubscribeForm" +
        ".cshtml")]
    public partial class SubscribeForm_SubscribeForm : System.Web.Mvc.WebViewPage<Telerik.Sitefinity.Frontend.EmailCampaigns.Mvc.Models.SubscribeFormViewModel>
    {
        public SubscribeForm_SubscribeForm()
        {
        }
        public override void Execute()
        {
WriteLiteral("\r\n");

WriteLiteral("\r\n");

            
            #line 10 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
Write(Html.Script(ScriptRef.JQuery, "top", false));

            
            #line default
            #line hidden
WriteLiteral("\r\n");

            
            #line 11 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
Write(Html.Script("//cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.21.0/jquery.validate.js", "top", false, new List<KeyValuePair<string, string>>() { HtmlConstants.CrossOriginHtmlAttribute }));

            
            #line default
            #line hidden
WriteLiteral("\r\n");

            
            #line 12 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
Write(Html.Script("//cdnjs.cloudflare.com/ajax/libs/jquery-validation-unobtrusive/4.0.0/jquery.validate.unobtrusive.min.js", "top", false, new List<KeyValuePair<string, string>>() { HtmlConstants.CrossOriginHtmlAttribute }));

            
            #line default
            #line hidden
WriteLiteral("\r\n\r\n");

            
            #line 14 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
  
    var hasValidationMessage = Html.ValidationMessageFor(m => m.Email) != null;
    var attributes = new Dictionary<string, object>()
{
        { "class", "form-control" },
        { "type", "email" },
        { "aria-required", "true" }
    };

    if (hasValidationMessage)
    {
        attributes.Add("aria-describedby", Html.UniqueId("SubscribeFormInfo") + " " + Html.UniqueId("SubscribeFormValidatonInfo"));
    }
    else
    {
        attributes.Add("aria-describedby", Html.UniqueId("SubscribeFormInfo"));
    }

            
            #line default
            #line hidden
WriteLiteral("\r\n\r\n<div");

WriteAttribute("class", Tuple.Create(" class=\"", 1336), Tuple.Create("\"", 1359)
            
            #line 33 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
, Tuple.Create(Tuple.Create("", 1344), Tuple.Create<System.Object, System.Int32>(Model.CssClass
            
            #line default
            #line hidden
, 1344), false)
);

WriteLiteral(">\r\n");

            
            #line 34 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
    
            
            #line default
            #line hidden
            
            #line 34 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
     using (Html.BeginFormSitefinity("Subscribe", "SubscribeForm"))
    {

            
            #line default
            #line hidden
WriteLiteral("        <h3>");

            
            #line 36 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
       Write(Html.Resource("Subscribe"));

            
            #line default
            #line hidden
WriteLiteral("</h3>\r\n");

            
            #line 37 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"


            
            #line default
            #line hidden
WriteLiteral("        <p");

WriteLiteral(" class=\"text-muted\"");

WriteAttribute("id", Tuple.Create(" id=\'", 1516), Tuple.Create("\'", 1556)
            
            #line 38 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
, Tuple.Create(Tuple.Create("", 1521), Tuple.Create<System.Object, System.Int32>(Html.UniqueId("SubscribeFormInfo")
            
            #line default
            #line hidden
, 1521), false)
);

WriteLiteral(">\r\n");

WriteLiteral("            ");

            
            #line 39 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
       Write(Html.Resource("SubscribeMail"));

            
            #line default
            #line hidden
WriteLiteral("\r\n        </p>\r\n");

            
            #line 41 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"

        if (ViewBag.IsSucceeded == true)
        {

            
            #line default
            #line hidden
WriteLiteral("            <div");

WriteLiteral(" class=\"alert alert-success\"");

WriteLiteral(" role=\"alert\"");

WriteLiteral(" aria-live=\"assertive\"");

WriteLiteral(">\r\n");

WriteLiteral("                ");

            
            #line 45 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
           Write(Html.Resource("ThankYou"));

            
            #line default
            #line hidden
WriteLiteral(". ");

            
            #line 45 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
                                       Write(Html.Resource("ThankYouMessage"));

            
            #line default
            #line hidden
WriteLiteral(" (");

            
            #line 45 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
                                                                          Write(ViewBag.Email);

            
            #line default
            #line hidden
WriteLiteral(")\r\n            </div>\r\n");

            
            #line 47 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
        }

        
            
            #line default
            #line hidden
            
            #line 49 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
   Write(Html.ValidationSummary(true));

            
            #line default
            #line hidden
            
            #line 49 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
                                     
        if (!string.IsNullOrEmpty(ViewBag.Error))
        {

            
            #line default
            #line hidden
WriteLiteral("            <div");

WriteLiteral(" class=\"alert alert-warning\"");

WriteLiteral(" role=\"alert\"");

WriteLiteral(" aria-live=\"assertive\"");

WriteLiteral(">\r\n");

WriteLiteral("                ");

            
            #line 53 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
           Write(ViewBag.Error);

            
            #line default
            #line hidden
WriteLiteral("\r\n            </div>\r\n");

            
            #line 55 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
        }

        
            
            #line default
            #line hidden
            
            #line 75 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
          


            
            #line default
            #line hidden
WriteLiteral("        <div");

WriteLiteral(" class=\"form-group\"");

WriteLiteral(">\r\n");

WriteLiteral("            ");

            
            #line 78 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
       Write(Html.LabelFor(u => u.Email, Html.Resource("Email")));

            
            #line default
            #line hidden
WriteLiteral("\r\n\r\n            <div");

WriteLiteral(" class=\"form-inline\"");

WriteLiteral(">\r\n");

WriteLiteral("                ");

            
            #line 81 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
           Write(Html.TextBoxFor(m => m.Email, attributes));

            
            #line default
            #line hidden
WriteLiteral("\r\n                <button");

WriteLiteral(" class=\"btn btn-primary ml-2\"");

WriteLiteral(" type=\"submit\"");

WriteLiteral(" ");

            
            #line 82 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
                                                               Write(SystemManager.IsDesignMode ? "disabled" : "");

            
            #line default
            #line hidden
WriteLiteral(">");

            
            #line 82 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
                                                                                                              Write(Html.Resource("ButtonSubscribe"));

            
            #line default
            #line hidden
WriteLiteral("</button>\r\n");

WriteLiteral("                ");

            
            #line 83 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
           Write(Html.AddSitefinityAntiforgeryToken());

            
            #line default
            #line hidden
WriteLiteral("\r\n            </div>\r\n\r\n");

            
            #line 86 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
            
            
            #line default
            #line hidden
            
            #line 86 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
             if (Html.ValidationMessageFor(m => m.Email) != null)
            {

            
            #line default
            #line hidden
WriteLiteral("                <div");

WriteAttribute("id", Tuple.Create(" id=\'", 3703), Tuple.Create("\'", 3752)
            
            #line 88 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
, Tuple.Create(Tuple.Create("", 3708), Tuple.Create<System.Object, System.Int32>(Html.UniqueId("SubscribeFormValidatonInfo")
            
            #line default
            #line hidden
, 3708), false)
);

WriteLiteral(" class=\"text-danger\"");

WriteLiteral(" role=\"alert\"");

WriteLiteral(" aria-live=\"assertive\"");

WriteLiteral(">\r\n                    <span");

WriteLiteral(" class=\"form-text\"");

WriteLiteral(">");

            
            #line 89 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
                                       Write(Html.ValidationMessageFor(u => u.Email));

            
            #line default
            #line hidden
WriteLiteral("</span>\r\n                </div>\r\n");

            
            #line 91 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
            }

            
            #line default
            #line hidden
WriteLiteral("        </div>\r\n");

            
            #line 93 "..\..\ResourcePackages\Bootstrap4\MVC\Views\SubscribeForm\SubscribeForm.SubscribeForm.cshtml"
    }

            
            #line default
            #line hidden
WriteLiteral("</div>\r\n");

        }
    }
}
#pragma warning restore 1591