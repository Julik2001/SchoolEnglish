using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Persistence
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddPersistence(this IServiceCollection services, 
            IConfiguration configuration)
        {
            var connectionString = configuration.GetConnectionString("Db");
            services.AddDbContext<SchoolEnglishDbContext>(options =>
            {
                options.UseSqlite(connectionString);
            });
            
            services.AddScoped<ISchoolEnglishDbContext>(provider => 
                provider.GetService<SchoolEnglishDbContext>());
            
            return services;
        }
    }
}
