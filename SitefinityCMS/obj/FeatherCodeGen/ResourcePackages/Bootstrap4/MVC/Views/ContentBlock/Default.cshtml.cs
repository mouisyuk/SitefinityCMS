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

namespace SitefinityCMS.ResourcePackages.Bootstrap4.MVC.Views.ContentBlock
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
    
    #line 3 "..\..MVC\Views\ContentBlock\Default.cshtml"
    using Telerik.Sitefinity.Frontend.Mvc.Helpers;
    
    #line default
    #line hidden
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("RazorGenerator", "2.0.0.0")]
    [System.Web.WebPages.PageVirtualPathAttribute("~/MVC/Views/ContentBlock/Default.cshtml")]
    public partial class Default : System.Web.Mvc.WebViewPage<Telerik.Sitefinity.Frontend.ContentBlock.Mvc.Models.IContentBlockModel>
    {
        public Default()
        {
        }
        public override void Execute()
        {
WriteLiteral("\r\n<div");

WriteAttribute("class", Tuple.Create(" class=\"", 136), Tuple.Create("\"", 166)
            
            #line 5 "..\..MVC\Views\ContentBlock\Default.cshtml"
, Tuple.Create(Tuple.Create("", 144), Tuple.Create<System.Object, System.Int32>(Model.WrapperCssClass
            
            #line default
            #line hidden
, 144), false)
);

WriteLiteral(" ");

            
            #line 5 "..\..MVC\Views\ContentBlock\Default.cshtml"
                               Write(Html.InlineEditingAttributes(Model.ProviderName, Model.ContentType, Model.SharedContentID));

            
            #line default
            #line hidden
WriteLiteral(">\r\n    <div ");

            
            #line 6 "..\..MVC\Views\ContentBlock\Default.cshtml"
    Write(Html.InlineEditingFieldAttributes("Content", "LongText"));

            
            #line default
            #line hidden
WriteLiteral(">");

            
            #line 6 "..\..MVC\Views\ContentBlock\Default.cshtml"
                                                              Write(Html.HtmlSanitize(Model.Content));

            
            #line default
            #line hidden
WriteLiteral("</div>    \r\n</div>");

        }
    }
}
#pragma warning restore 1591