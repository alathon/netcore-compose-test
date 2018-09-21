using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;

namespace IAM
{
    public class Startup
    {
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddMvc();
            services.AddIdentityServer()
                    .AddDeveloperSigningCredential(true, "tempkey.rsa")
                    .AddInMemoryApiResources(IdentityServerSampleConfig.GetApiResources())
                    .AddInMemoryIdentityResources(IdentityServerSampleConfig.GetIdentityResources())
                    .AddInMemoryClients(IdentityServerSampleConfig.GetClients())
                    .AddTestUsers(IdentityServerSampleConfig.GetUsers());
        }

        public void Configure(IApplicationBuilder app, IHostingEnvironment envloggerFactory)
        {
            app.UseDeveloperExceptionPage();
            app.UseIdentityServer();
            app.UseStaticFiles();
            app.UseMvcWithDefaultRoute();
        }
    }
}
