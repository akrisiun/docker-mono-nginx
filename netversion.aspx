<%@ Page Language="C#" %>
<%@ Import Namespace="System.Web" %>
<%

    Response.Write(".NET Version: " + System.Environment.Version.ToString());

    Response.Write("<br><h2>Hello world <b>nginx-mono</b></h2>\n");
    
    Response.Write("<pre>");
    Response.Write("Docker commands:");
    Response.Write("<br/>docker build -t nginx-mono .");
    Response.Write("<br/>docker run -it -p 8081:80 --name monoweb1 nginx-mono");
    Response.Write("<br/>docker run --rm -it -p 8080:80 --name web2-rm nginx-mono");
    Response.Write(@"<br/>Source: <a 
        href=""https://github.com/seif/docker-mono-nginx""
        >https://github.com/seif/docker-mono-nginx</a>");
    Response.Write(@"<br/>Mono fastcgi: <a         
        href=""http://www.mono-project.com/docs/web/fastcgi/nginx/""
        >http://www.mono-project.com/docs/web/fastcgi/nginx/</a>");
    
    Response.Write("<br/>");
    Response.Write("<br/>Aspx InstallDirectory=" + System.Web.HttpRuntime.AspInstallDirectory.ToString());
    Response.Write("<br/>AppDomain.BaseDirectory=" + System.AppDomain.CurrentDomain.BaseDirectory);

    try {
        // Trans.LoadXmlAspx(this);
        // RazorGenerator.Mvc.EngineDebug.Output(Response);
    }
    catch { ; }

    Response.Write("<br/>Assemblies=" + System.AppDomain.CurrentDomain.GetAssemblies().Length.ToString());

    foreach (var asm in System.AppDomain.CurrentDomain.GetAssemblies()) {
        try {
            Response.Write("<br/>" + asm.CodeBase.Replace("file:///", ""));
        }
        catch {
            // case: Anonymously Hosted DynamicMethods Assembly
            Response.Write("<br/>" + asm.FullName);
        }
    }

    Response.Write("<br>\n</pre>");
          
%>