using MediatR;
using Microsoft.IdentityModel.Tokens;
using SchoolEnglish.Application.Common.Helpers;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;

namespace SchoolEnglish.Application.Users.Queries.AuthenticateUser
{
    public class AuthenticateUserHandler : IRequestHandler<AuthenticateUserQuery, string>
    {
        public async Task<string> Handle(AuthenticateUserQuery request, CancellationToken cancellationToken)
        {
            var claims = new List<Claim>
            {
                new Claim(ClaimsIdentity.DefaultNameClaimType, request.UserId.ToString()),
                new Claim(ClaimsIdentity.DefaultRoleClaimType, request.RoleId.ToString()),
            };

            var jwt = new JwtSecurityToken(
                            issuer: JwtParamsHelper.Issuer,
                            audience: JwtParamsHelper.Audience,
                            claims: claims,
                            signingCredentials: new SigningCredentials(JwtParamsHelper.GetSymmetricSecurityKey(), SecurityAlgorithms.HmacSha256));

            return new JwtSecurityTokenHandler().WriteToken(jwt);
        }
    }
}
