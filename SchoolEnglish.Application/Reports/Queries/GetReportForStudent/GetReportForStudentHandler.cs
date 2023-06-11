using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Common.Helpers;
using SchoolEnglish.Application.Interfaces;

namespace SchoolEnglish.Application.Reports.Queries.GetReportForStudent
{
    public class GetReportForStudentHandler : IRequestHandler<GetReportForStudentQuery, StudentReportVm>
    {
        private readonly ISchoolEnglishDbContext _dbContext;

        public GetReportForStudentHandler(ISchoolEnglishDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        public async Task<StudentReportVm> Handle(GetReportForStudentQuery request, CancellationToken cancellationToken)
        {
            StudentReportVm vm = new StudentReportVm();

            var answers = await _dbContext.UserAnswers.Where(answer =>
                    answer.TaskPart.TaskId == request.TaskId && answer.UserId == request.UserId)
                .Select(answer => new KeyValuePair<string, string>(answer.Answer, answer.TaskPart.RightAnswer)).ToListAsync();

            var correctAnswers = answers.Count(answer => AnswersHelper.CheckAnswer(answer.Key, answer.Value));
            vm.CorrectAnswers = correctAnswers;

            var wrongAnswers = answers.Count(answer => !AnswersHelper.CheckAnswer(answer.Key, answer.Value));
            vm.WrongAnswers = wrongAnswers;

            var percentage = correctAnswers / (double) (correctAnswers + wrongAnswers) * 100;

            if (percentage < 50) vm.Grade = 2;
            else if (percentage < 70) vm.Grade = 3;
            else if (percentage < 90) vm.Grade = 4;
            else vm.Grade = 5;

            return vm;
        }
    }
}
