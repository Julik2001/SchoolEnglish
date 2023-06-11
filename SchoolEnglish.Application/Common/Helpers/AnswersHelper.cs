namespace SchoolEnglish.Application.Common.Helpers
{
    public static class AnswersHelper
    {
        public static bool CheckAnswer(string answer, string rightAnswer) =>
            answer == rightAnswer || 
            ToUpperFirstLetter(answer) == ToUpperFirstLetter(rightAnswer);

        private static string ToUpperFirstLetter(string source)
        {
            if (string.IsNullOrEmpty(source))
                return string.Empty;

            var letters = source.ToCharArray();
            if (letters.Length > 0)
            {
                letters[0] = char.ToUpper(letters[0]);
            }

            return new string(letters);
        }
    }
}
