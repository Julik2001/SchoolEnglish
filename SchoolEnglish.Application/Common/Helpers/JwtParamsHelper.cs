using Microsoft.IdentityModel.Tokens;
using System.Text;

namespace SchoolEnglish.Application.Common.Helpers
{
    public static class JwtParamsHelper
    {
        public static readonly string Issuer = "SchoolEnglishAuth";
        public static readonly string Audience = "SchoolEnglishClient";
        public static readonly string Key = "SecretKeyForAppWithLengthMoreThan16Bytes";

        public static SymmetricSecurityKey GetSymmetricSecurityKey() =>
            new SymmetricSecurityKey(Encoding.UTF8.GetBytes(Key));
    }
}
