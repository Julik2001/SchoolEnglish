﻿using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.Reports.Queries.GetReportForTeacher
{
    public class GetReportForTeacherHandler : IRequestHandler<GetReportForTeacherQuery, TeacherReportVm>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public GetReportForTeacherHandler(ISchoolEnglishDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task<TeacherReportVm> Handle(GetReportForTeacherQuery request, CancellationToken cancellationToken)
        {
            TeacherReportVm vm = new TeacherReportVm();

            var tasksCompleted = await _dbContext.UserAnswers.Where(answer => answer.UserId == request.StudentId)
                .Select(answer => answer.TaskPart.Task).Distinct().CountAsync();
            vm.TasksCompleted = tasksCompleted;

            var correctAnswers = await _dbContext.UserAnswers.Where(answer => answer.UserId == request.StudentId)
                .CountAsync(answer => answer.Answer == answer.TaskPart.RightAnswer);

            var wrongAnswers = await _dbContext.UserAnswers.Where(answer => answer.UserId == request.StudentId)
                .CountAsync(answer => answer.Answer != answer.TaskPart.RightAnswer);

            var percentage = correctAnswers / (double)(correctAnswers + wrongAnswers) * 100;
            vm.CorrectAnswersPercentage = percentage;

            if (percentage < 50) vm.AverageGrade = 2;
            else if (percentage < 70) vm.AverageGrade = 3;
            else if (percentage < 90) vm.AverageGrade = 4;
            else vm.AverageGrade = 5;

            return vm;
        }
    }
}
