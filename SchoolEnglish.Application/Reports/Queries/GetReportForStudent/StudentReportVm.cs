namespace SchoolEnglish.Application.Reports.Queries.GetReportForStudent
{
    public class StudentReportVm
    {
        public int CorrectAnswers { get; set; }
        public int WrongAnswers { get; set; }
        public int Grade { get; set; }
        public int Reward { get; set; }
    }
}
