using AutoMapper;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Mvc;
using SchoolEnglish.Application.Users.Commands.CreateUser;
using SchoolEnglish.Application.Users.Queries.AuthenticateUser;
using SchoolEnglish.Application.Users.Queries.GetUser;
using SchoolEnglish.WebApi.Models;

namespace SchoolEnglish.WebApi.Controllers
{
    [ApiController]
    public class AuthController : BaseController
    {
        private readonly IMapper _mapper;

        public AuthController(IMapper mapper)
        {
            _mapper = mapper;
        }

        [HttpPost]
        public async Task<ActionResult<string>> Login([FromBody] LoginUserDto loginUserDto)
        {
            var query = _mapper.Map<GetUserQuery>(loginUserDto);
            var user = await Mediator.Send(query);

            var authQuery = new AuthenticateUserQuery
            {
                UserId = user.Id,
                RoleId = user.RoleId,
            };
            var jwt = await Mediator.Send(authQuery);

            return Ok(jwt);
        }

        [HttpPost]
        public async Task<ActionResult<string>> Register([FromBody] RegisterUserDto registerUserDto)
        {
            var command = _mapper.Map<CreateUserCommand>(registerUserDto);
            var userId = await Mediator.Send(command);

            var authQuery = new AuthenticateUserQuery
            {
                UserId = userId,
                RoleId = registerUserDto.RoleId,
            };
            var jwt = await Mediator.Send(authQuery);

            return Ok(jwt);
        }

        [HttpGet]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(JwtBearerDefaults.AuthenticationScheme);
            return Ok();
        }
    }
}
