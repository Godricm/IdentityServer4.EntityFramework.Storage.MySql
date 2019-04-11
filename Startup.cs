using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using IdentityServer4.EntityFramework.Storage;
using Microsoft.EntityFrameworkCore;

namespace MySql
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            var cn = Configuration.GetConnectionString("db");

            services.AddOperationalDbContext(options => {
                options.ConfigureDbContext = b =>
                    b.UseMySQL(cn, dbOpts => dbOpts.MigrationsAssembly(typeof(Startup).Assembly.FullName));
            });

            services.AddConfigurationDbContext(options => {
                options.ConfigureDbContext = b =>
                    b.UseMySQL(cn, dbOpts => dbOpts.MigrationsAssembly(typeof(Startup).Assembly.FullName));
            });
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env)
        {
          
        }
    }
}
