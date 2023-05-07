using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SchoolEnglish.Application.Common.Helpers;
using SchoolEnglish.Application.Users.Commands.CreateUser;
using SchoolEnglish.Application.Users.Commands.GenerateUserTeacherCode;
using SchoolEnglish.Application.Users.Commands.UpdateUserTeacherCode;
using SchoolEnglish.Application.Users.Queries.AuthenticateUser;
using SchoolEnglish.Application.Users.Queries.GetUserByEmailAndPassword;
using SchoolEnglish.Application.Users.Queries.GetUserById;
using SchoolEnglish.WebApi.Models;
using System.Security.Claims;

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
            var query = _mapper.Map<GetUserByEmailAndPasswordQuery>(loginUserDto);
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
            var createUserCommand = _mapper.Map<CreateUserCommand>(registerUserDto);
            var userId = await Mediator.Send(createUserCommand);

            var getUserQuery = new GetUserByIdQuery { UserId = userId };
            var user = await Mediator.Send(getUserQuery);

            if (user.RoleId == BaseRolesHelper.TeacherRole.Id)
            {
                var command = new GenerateUserTeacherCodeCommand { User = user };
                await Mediator.Send(command);
            }

            var authQuery = new AuthenticateUserQuery
            {
                UserId = userId,
                RoleId = registerUserDto.RoleId,
            };
            var jwt = await Mediator.Send(authQuery);

            return Ok(jwt);
        }

        [Authorize]
        [HttpGet]
        public async Task<ActionResult<string>> GetUserFullname()
        {
            var userIdClaim = User.Claims.FirstOrDefault(claim => claim.Type == ClaimsIdentity.DefaultNameClaimType);
            if (userIdClaim == null)
            {
                return BadRequest();
            }
            var getUserQuery = new GetUserByIdQuery { UserId = Guid.Parse(userIdClaim.Value) };
            var user = await Mediator.Send(getUserQuery);

            return Ok($"{user.Surname} {user.Name}");
        }

        [Authorize]
        [HttpGet]
        public async Task<ActionResult<string>> GetTeacherCode()
        {
            var roleClaim = User.Claims.FirstOrDefault(claim => claim.Type == ClaimsIdentity.DefaultRoleClaimType);
            if (roleClaim == null)
            {
                return BadRequest();
            }
            else if (Guid.Parse(roleClaim.Value) != BaseRolesHelper.TeacherRole.Id)
            {
                return Forbid();
            }

            var userIdClaim = User.Claims.FirstOrDefault(claim => claim.Type == ClaimsIdentity.DefaultNameClaimType);
            if (userIdClaim == null)
            {
                return BadRequest();
            }
            var getUserQuery = new GetUserByIdQuery { UserId = Guid.Parse(userIdClaim.Value) };
            var user = await Mediator.Send(getUserQuery);

            return Ok(user.TeacherCode);
        }

        [Authorize]
        [HttpGet("{teacherCode}")]
        public async Task<IActionResult> UpdateTeacherCode(string teacherCode)
        {
            var roleClaim = User.Claims.FirstOrDefault(claim => claim.Type == ClaimsIdentity.DefaultRoleClaimType);
            if (roleClaim == null)
            {
                return BadRequest();
            }
            else if (Guid.Parse(roleClaim.Value) != BaseRolesHelper.StudentRole.Id)
            {
                return Forbid();
            }

            var userIdClaim = User.Claims.FirstOrDefault(claim => claim.Type == ClaimsIdentity.DefaultNameClaimType);
            if (userIdClaim == null)
            {
                return BadRequest();
            }
            var getUserQuery = new GetUserByIdQuery { UserId = Guid.Parse(userIdClaim.Value) };
            var user = await Mediator.Send(getUserQuery);

            var updateTeacherCodeCommand = new UpdateUserTeacherCodeCommand { User = user, TeacherCode = teacherCode };
            await Mediator.Send(updateTeacherCodeCommand);

            return Ok();
        }
    }
}
