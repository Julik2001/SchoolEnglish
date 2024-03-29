﻿using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.Tasks.Commands.CreateOrUpdateTask
{
    public class CreateOrUpdateTaskHandler : IRequestHandler<CreateOrUpdateTaskCommand, Guid>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public CreateOrUpdateTaskHandler(ISchoolEnglishDbContext dbContext) =>
            _dbContext = dbContext;

        public async Task<Guid> Handle(CreateOrUpdateTaskCommand request, CancellationToken cancellationToken)
        {
            Domain.Task? task = null;
            if (request.Id != null && request.Id != Guid.Empty)
            {
                task = await _dbContext.Tasks.FirstOrDefaultAsync(role =>
                    role.Id == request.Id, cancellationToken);
            }

            if (task == null)
            {
                task = new Domain.Task
                {
                    Id = Guid.NewGuid(),
                    Header = request.Header,
                    TimeInMinutes = request.TimeInMinutes,
                    Reward = request.Reward,
                    ModuleId = request.ModuleId,
                };
                await _dbContext.Tasks.AddAsync(task, cancellationToken);
            }
            else
            {
                task.Header = request.Header;
                task.TimeInMinutes = request.TimeInMinutes;
                task.Reward = request.Reward;
                task.ModuleId = request.ModuleId;
            }

            await _dbContext.SaveChangesAsync(cancellationToken);

            return task.Id;
        }
    }
}
