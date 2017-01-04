// https://kerrick.wordpress.com/2007/06/12/make-any-net-app-a-web-server/

using System.Web;

namespace Web {

    public static class RunXsp
    {

        public static void Start()
        {
            XSPWebSource source = new XSPWebSource (System.Net.IPAddress.Any, 8080);
            server = new ApplicationServer (source);
            server.AddApplicationsFromCommandLine ("/:/path/to/asp.net/application");
            server.Start (true);
        }
    }
}
