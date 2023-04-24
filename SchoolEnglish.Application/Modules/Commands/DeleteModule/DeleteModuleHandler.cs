using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;
using SchoolEnglish.Application.Common.Exceptions;

namespace SchoolEnglish.Application.Modules.Commands.DeleteModule
{
    public class DeleteModuleHandler : IRequestHandler<DeleteModuleCommand>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public DeleteModuleHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task Handle(DeleteModuleCommand request, CancellationToken cancellationToken)
        {

            var module = await _dbContext.Modules.FirstOrDefaultAsync(module =>
                module.Id == request.Id, cancellationToken);

            if (module == null)
            {
                throw new NotFoundException(nameof(module), request.Id);
            }

            _dbContext.Modules.Remove(module);
            await _dbContext.SaveChangesAsync(cancellationToken);
        }
    }
}
