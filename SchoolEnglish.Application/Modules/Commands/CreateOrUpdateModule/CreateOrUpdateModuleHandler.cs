using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;
using SchoolEnglish.Domain;

namespace SchoolEnglish.Application.Modules.Commands.CreateOrUpdateModule
{
    public class CreateOrUpdateModuleHandler : IRequestHandler<CreateOrUpdateModuleCommand, Guid>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public CreateOrUpdateModuleHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task<Guid> Handle(CreateOrUpdateModuleCommand request, CancellationToken cancellationToken)
        {
            Module? module = null;
            if (request.Id != null && request.Id != Guid.Empty)
            {
                module = await _dbContext.Modules.FirstOrDefaultAsync(module =>
                    module.Id == request.Id, cancellationToken);
            }

            if (module == null)
            {
                module = new Module
                {
                    Id = Guid.NewGuid(),
                    Name = request.Name,
                    Number = request.Number,
                    ParentId = request.ParentId,
                };
                await _dbContext.Modules.AddAsync(module, cancellationToken);
            }
            else
            {
                module.Name = request.Name;
                module.Number = request.Number;
                module.ParentId = request.ParentId;
            }

            await _dbContext.SaveChangesAsync(cancellationToken);

            return module.Id;
        }
    }
}
