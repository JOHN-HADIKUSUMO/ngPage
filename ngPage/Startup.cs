using Microsoft.Owin;
using Owin;
using ngPage.Models;
using ngPage.Database;
using ngPage.Services;

[assembly: OwinStartupAttribute(typeof(ngPage.Startup))]
namespace ngPage
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
