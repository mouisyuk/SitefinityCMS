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

namespace SitefinityCMS.ResourcePackages.Bootstrap5.MVC.Views.TextField
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
    
    #line 4 "..\..MVC\Views\TextField\Write.Default.cshtml"
    using Telerik.Sitefinity.Frontend.Forms.Mvc.Helpers;
    
    #line default
    #line hidden
    
    #line 7 "..\..MVC\Views\TextField\Write.Default.cshtml"
    using Telerik.Sitefinity.Frontend.Forms.Mvc.Models.Fields.TextField;
    
    #line default
    #line hidden
    
    #line 5 "..\..MVC\Views\TextField\Write.Default.cshtml"
    using Telerik.Sitefinity.Frontend.Mvc.Helpers;
    
    #line default
    #line hidden
    
    #line 6 "..\..MVC\Views\TextField\Write.Default.cshtml"
    using Telerik.Sitefinity.Modules.Pages;
    
    #line default
    #line hidden
    
    #line 3 "..\..MVC\Views\TextField\Write.Default.cshtml"
    using Telerik.Sitefinity.UI.MVC;
    
    #line default
    #line hidden
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("RazorGenerator", "2.0.0.0")]
    [System.Web.WebPages.PageVirtualPathAttribute("~/MVC/Views/TextField/Write.Default.cshtml")]
    public partial class Write_Default : System.Web.Mvc.WebViewPage<Telerik.Sitefinity.Frontend.Forms.Mvc.Models.Fields.TextField.TextFieldViewModel>
    {
        public Write_Default()
        {
        }
        public override void Execute()
        {
WriteLiteral("\r\n");

            
            #line 9 "..\..MVC\Views\TextField\Write.Default.cshtml"
Write(Html.Script(ScriptRef.JQuery, "jquery", false));

            
            #line default
            #line hidden
WriteLiteral("\r\n<!-- InputCssClass class variable -->\r\n\r\n");

            
            #line 12 "..\..MVC\Views\TextField\Write.Default.cshtml"
   
    var inputCssClass = "";
    HashSet<TextType> availableOptions = new HashSet<TextType>() { TextType.Text, TextType.Password, TextType.Date, TextType.DateTimeLocal, TextType.Month, TextType.Time,
    TextType.Week, TextType.Number, TextType.Email, TextType.Url, TextType.Tel, TextType.Color };

    if (availableOptions.Contains(Model.InputType))
    {
        inputCssClass = "form-control";
    }

    var isRequired = Model.ValidatorDefinition.Required.HasValue && Model.ValidatorDefinition.Required.Value ? "true" : "false";
    var hasDescription = !string.IsNullOrEmpty(Model.MetaField.Description);

            
            #line default
            #line hidden
WriteLiteral("\r\n\r\n<div");

WriteAttribute("class", Tuple.Create(" class=\"", 1069), Tuple.Create("\"", 1097)
            
            #line 26 "..\..MVC\Views\TextField\Write.Default.cshtml"
, Tuple.Create(Tuple.Create("", 1077), Tuple.Create<System.Object, System.Int32>(Model.CssClass
            
            #line default
            #line hidden
, 1077), false)
, Tuple.Create(Tuple.Create(" ", 1092), Tuple.Create("my-3", 1093), true)
);

WriteLiteral(" data-sf-role=\"text-field-container\"");

WriteLiteral(">\r\n    <input");

WriteLiteral(" data-sf-role=\"violation-restrictions\"");

WriteLiteral(" type=\"hidden\"");

WriteAttribute("value", Tuple.Create(" value=\'", 1199), Tuple.Create("\'", 1312)
, Tuple.Create(Tuple.Create("", 1207), Tuple.Create("{\"maxLength\":\"", 1207), true)
            
            #line 27 "..\..MVC\Views\TextField\Write.Default.cshtml"
    , Tuple.Create(Tuple.Create("", 1221), Tuple.Create<System.Object, System.Int32>(Model.ValidatorDefinition.MaxLength
            
            #line default
            #line hidden
, 1221), false)
, Tuple.Create(Tuple.Create("", 1257), Tuple.Create("\",", 1257), true)
, Tuple.Create(Tuple.Create(" ", 1259), Tuple.Create("\"minLength\":", 1260), true)
, Tuple.Create(Tuple.Create(" ", 1272), Tuple.Create("\"", 1273), true)
            
            #line 27 "..\..MVC\Views\TextField\Write.Default.cshtml"
                                                         , Tuple.Create(Tuple.Create("", 1274), Tuple.Create<System.Object, System.Int32>(Model.ValidatorDefinition.MinLength
            
            #line default
            #line hidden
, 1274), false)
, Tuple.Create(Tuple.Create("", 1310), Tuple.Create("\"}", 1310), true)
);

WriteLiteral(" />\r\n    <input");

WriteLiteral(" data-sf-role=\"violation-messages\"");

WriteLiteral(" type=\"hidden\"");

WriteAttribute("value", Tuple.Create(" value=\'", 1376), Tuple.Create("\'", 1656)
, Tuple.Create(Tuple.Create("", 1384), Tuple.Create("{\"maxLength\":\"", 1384), true)
            
            #line 28 "..\..MVC\Views\TextField\Write.Default.cshtml"
, Tuple.Create(Tuple.Create("", 1398), Tuple.Create<System.Object, System.Int32>(Model.ValidatorDefinition.MaxLengthViolationMessage
            
            #line default
            #line hidden
, 1398), false)
, Tuple.Create(Tuple.Create("", 1450), Tuple.Create("\",", 1450), true)
, Tuple.Create(Tuple.Create(" ", 1452), Tuple.Create("\"required\":", 1453), true)
, Tuple.Create(Tuple.Create(" ", 1464), Tuple.Create("\"", 1465), true)
            
            #line 28 "..\..MVC\Views\TextField\Write.Default.cshtml"
                                                                    , Tuple.Create(Tuple.Create("", 1466), Tuple.Create<System.Object, System.Int32>(Model.ValidatorDefinition.RequiredViolationMessage
            
            #line default
            #line hidden
, 1466), false)
, Tuple.Create(Tuple.Create("", 1517), Tuple.Create("\",", 1517), true)
, Tuple.Create(Tuple.Create(" ", 1519), Tuple.Create("\"invalid\":", 1520), true)
, Tuple.Create(Tuple.Create(" ", 1530), Tuple.Create("\"", 1531), true)
            
            #line 28 "..\..MVC\Views\TextField\Write.Default.cshtml"
                                                                                                                                      , Tuple.Create(Tuple.Create("", 1532), Tuple.Create<System.Object, System.Int32>(Html.Resource("InvalidEntryMessage")
            
            #line default
            #line hidden
, 1532), false)
, Tuple.Create(Tuple.Create("", 1569), Tuple.Create("\",", 1569), true)
, Tuple.Create(Tuple.Create(" ", 1571), Tuple.Create("\"regularExpression\":", 1572), true)
, Tuple.Create(Tuple.Create(" ", 1592), Tuple.Create("\"", 1593), true)
            
            #line 28 "..\..MVC\Views\TextField\Write.Default.cshtml"
                                                                                                                                                                                                    , Tuple.Create(Tuple.Create("", 1594), Tuple.Create<System.Object, System.Int32>(Model.ValidatorDefinition.RegularExpressionViolationMessage
            
            #line default
            #line hidden
, 1594), false)
, Tuple.Create(Tuple.Create("", 1654), Tuple.Create("\"}", 1654), true)
);

WriteLiteral(" />\r\n\r\n    <label");

WriteLiteral(" class=\"form-label\"");

WriteAttribute("for", Tuple.Create(" for=\'", 1693), Tuple.Create("\'", 1724)
            
            #line 30 "..\..MVC\Views\TextField\Write.Default.cshtml"
, Tuple.Create(Tuple.Create("", 1699), Tuple.Create<System.Object, System.Int32>(Html.UniqueId("Textbox")
            
            #line default
            #line hidden
, 1699), false)
);

WriteLiteral(">");

            
            #line 30 "..\..MVC\Views\TextField\Write.Default.cshtml"
                                                         Write(Model.MetaField.Title);

            
            #line default
            #line hidden
WriteLiteral("</label>\r\n    <input");

WriteAttribute("id", Tuple.Create(" \r\n        id=\'", 1768), Tuple.Create("\'", 1808)
            
            #line 32 "..\..MVC\Views\TextField\Write.Default.cshtml"
, Tuple.Create(Tuple.Create("", 1783), Tuple.Create<System.Object, System.Int32>(Html.UniqueId("Textbox")
            
            #line default
            #line hidden
, 1783), false)
);

WriteAttribute("type", Tuple.Create("\r\n        type=\"", 1809), Tuple.Create("\"", 1859)
            
            #line 33 "..\..MVC\Views\TextField\Write.Default.cshtml"
, Tuple.Create(Tuple.Create("", 1825), Tuple.Create<System.Object, System.Int32>(Model.InputType.ToHtmlInputType()
            
            #line default
            #line hidden
, 1825), false)
);

WriteAttribute("class", Tuple.Create("\r\n        class=\"", 1860), Tuple.Create("\"", 1891)
            
            #line 34 "..\..MVC\Views\TextField\Write.Default.cshtml"
, Tuple.Create(Tuple.Create("", 1877), Tuple.Create<System.Object, System.Int32>(inputCssClass
            
            #line default
            #line hidden
, 1877), false)
);

WriteAttribute("name", Tuple.Create("\r\n        name=\"", 1892), Tuple.Create("\"", 1934)
            
            #line 35 "..\..MVC\Views\TextField\Write.Default.cshtml"
, Tuple.Create(Tuple.Create("", 1908), Tuple.Create<System.Object, System.Int32>(Model.MetaField.FieldName
            
            #line default
            #line hidden
, 1908), false)
);

WriteAttribute("placeholder", Tuple.Create("\r\n        placeholder=\"", 1935), Tuple.Create("\"", 1980)
            
            #line 36 "..\..MVC\Views\TextField\Write.Default.cshtml"
, Tuple.Create(Tuple.Create("", 1958), Tuple.Create<System.Object, System.Int32>(Model.PlaceholderText
            
            #line default
            #line hidden
, 1958), false)
);

WriteAttribute("value", Tuple.Create("\r\n        value=\"", 1981), Tuple.Create("\"", 2010)
            
            #line 37 "..\..MVC\Views\TextField\Write.Default.cshtml"
, Tuple.Create(Tuple.Create("", 1998), Tuple.Create<System.Object, System.Int32>(Model.Value
            
            #line default
            #line hidden
, 1998), false)
);

WriteAttribute("aria-required", Tuple.Create("\r\n        aria-required=\"", 2011), Tuple.Create("\"", 2047)
            
            #line 38 "..\..MVC\Views\TextField\Write.Default.cshtml"
, Tuple.Create(Tuple.Create("", 2036), Tuple.Create<System.Object, System.Int32>(isRequired
            
            #line default
            #line hidden
, 2036), false)
);

WriteLiteral("\r\n        data-sf-role=\"text-field-input\"");

WriteLiteral("\r\n        ");

            
            #line 40 "..\..MVC\Views\TextField\Write.Default.cshtml"
   Write(Html.Raw(Model.ValidationAttributes));

            
            #line default
            #line hidden
WriteLiteral("\r\n");

            
            #line 41 "..\..MVC\Views\TextField\Write.Default.cshtml"
        
            
            #line default
            #line hidden
            
            #line 41 "..\..MVC\Views\TextField\Write.Default.cshtml"
          if (hasDescription) {
            
            #line default
            #line hidden
WriteLiteral(" ");

WriteLiteral("aria-describedby=\'");

            
            #line 41 "..\..MVC\Views\TextField\Write.Default.cshtml"
                                                   Write(Html.UniqueId("TextboxInfo"));

            
            #line default
            #line hidden
WriteLiteral(" ");

            
            #line 41 "..\..MVC\Views\TextField\Write.Default.cshtml"
                                                                                 Write(Html.UniqueId("TextboxErrorMessage"));

            
            #line default
            #line hidden
WriteLiteral("\'");

WriteLiteral(" ");

            
            #line 41 "..\..MVC\Views\TextField\Write.Default.cshtml"
                                                                                                                                    } else {
            
            #line default
            #line hidden
WriteLiteral(" ");

WriteLiteral("aria-describedby=\'");

            
            #line 41 "..\..MVC\Views\TextField\Write.Default.cshtml"
                                                                                                                                                                Write(Html.UniqueId("TextboxErrorMessage"));

            
            #line default
            #line hidden
WriteLiteral("\'");

WriteLiteral(" ");

            
            #line 41 "..\..MVC\Views\TextField\Write.Default.cshtml"
                                                                                                                                                                                                                   } 
            
            #line default
            #line hidden
WriteLiteral(" />\r\n        \r\n    <div");

WriteAttribute("id", Tuple.Create(" id=\'", 2375), Tuple.Create("\'", 2417)
            
            #line 43 "..\..MVC\Views\TextField\Write.Default.cshtml"
, Tuple.Create(Tuple.Create("", 2380), Tuple.Create<System.Object, System.Int32>(Html.UniqueId("TextboxErrorMessage")
            
            #line default
            #line hidden
, 2380), false)
);

WriteLiteral(" data-sf-role=\"error-message\"");

WriteLiteral(" role=\"alert\"");

WriteLiteral(" aria-live=\"assertive\"");

WriteLiteral(" class=\"invalid-feedback\"");

WriteLiteral("></div>\r\n\r\n");

            
            #line 45 "..\..MVC\Views\TextField\Write.Default.cshtml"
     
            
            #line default
            #line hidden
            
            #line 45 "..\..MVC\Views\TextField\Write.Default.cshtml"
      if (hasDescription) 
     {

            
            #line default
            #line hidden
WriteLiteral("         <p");

WriteAttribute("id", Tuple.Create(" id=\'", 2565), Tuple.Create("\'", 2599)
            
            #line 47 "..\..MVC\Views\TextField\Write.Default.cshtml"
, Tuple.Create(Tuple.Create("", 2570), Tuple.Create<System.Object, System.Int32>(Html.UniqueId("TextboxInfo")
            
            #line default
            #line hidden
, 2570), false)
);

WriteLiteral(" class=\"form-text\"");

WriteLiteral(">");

            
            #line 47 "..\..MVC\Views\TextField\Write.Default.cshtml"
                                                            Write(Model.MetaField.Description);

            
            #line default
            #line hidden
WriteLiteral("</p>\r\n");

            
            #line 48 "..\..MVC\Views\TextField\Write.Default.cshtml"
     }

            
            #line default
            #line hidden
WriteLiteral("\r\n     \r\n</div>\r\n\r\n");

            
            #line 53 "..\..MVC\Views\TextField\Write.Default.cshtml"
Write(Html.Script(Url.WidgetContent("Mvc/Scripts/TextField/text-field.js"), "bottom", false));

            
            #line default
            #line hidden
WriteLiteral("\r\n");

        }
    }
}
#pragma warning restore 1591