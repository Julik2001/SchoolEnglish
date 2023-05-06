using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SchoolEnglish.Application.Common.Helpers;
using SchoolEnglish.Application.Roles.Commands.CreateOrUpdateRole;
using SchoolEnglish.Application.Roles.Commands.DeleteRole;
using SchoolEnglish.Application.Roles.Queries.CheckUserIsModerator;
using SchoolEnglish.Application.Roles.Queries.CheckUserIsStudent;
using SchoolEnglish.Application.Roles.Queries.CheckUserIsTeacher;
using SchoolEnglish.Application.Roles.Queries.GetRoles;
using SchoolEnglish.Domain;
using SchoolEnglish.WebApi.Models;
using System.Security.Claims;

namespace SchoolEnglish.WebApi.Controllers
{
    [ApiController]
    public class RoleController : BaseController
    {
        private readonly IMapper _mapper;

        public RoleController(IMapper mapper)
        {
            _mapper = mapper;
        }

        [Authorize]
        [HttpGet]
        public async Task<ActionResult<RolesVm>> GetRoles()
        {
            var query = new GetRolesQuery();
            var vm = await Mediator.Send(query);
            return Ok(vm);
        }

        [Authorize]
        [HttpPost]
        public async Task<ActionResult<Guid>> CreateOrUpdate([FromBody] CreateOrUpdateRoleDto createOrUpdateRoleDto)
        {
            var command = _mapper.Map<CreateOrUpdateRoleCommand>(createOrUpdateRoleDto);
            var roleId = await Mediator.Send(command);
            return Ok(roleId);
        }

        [Authorize]
        [HttpDelete("{roleId}")]
        public async Task<IActionResult> Delete(Guid roleId)
        {
            var command = new DeleteRoleCommand { Id = roleId };
            await Mediator.Send(command);
            return Ok();
        }

        [HttpGet]
        public async Task<ActionResult<Role>> GetTeacherRole()
        {
            return BaseRolesHelper.TeacherRole;
        }

        [HttpGet]
        public async Task<ActionResult<Role>> GetStudentRole()
        {
            return BaseRolesHelper.StudentRole;
        }

        [Authorize]
        [HttpGet]
        public async Task<ActionResult<bool>> CheckRoleIsTeacher()
        {
            var roleClaim = User.Claims.FirstOrDefault(claim => claim.Type == ClaimsIdentity.DefaultRoleClaimType);
            if (roleClaim == null)
            {
                return BadRequest();
            }

            var query = new CheckRoleIsTeacherQuery { RoleId = Guid.Parse(roleClaim.Value) };
            var roleIsTeacher = await Mediator.Send(query);

            return roleIsTeacher;
        }

        [Authorize]
        [HttpGet]
        public async Task<ActionResult<bool>> CheckRoleIsStudent()
        {
            var roleClaim = User.Claims.FirstOrDefault(claim => claim.Type == ClaimsIdentity.DefaultRoleClaimType);
            if (roleClaim == null)
            {
                return BadRequest();
            }

            var query = new CheckRoleIsStudentQuery { RoleId = Guid.Parse(roleClaim.Value) };
            var roleIsStudent = await Mediator.Send(query);

            return roleIsStudent;
        }

        [Authorize]
        [HttpGet]
        public async Task<ActionResult<bool>> CheckRoleIsModerator()
        {
            var roleClaim = User.Claims.FirstOrDefault(claim => claim.Type == ClaimsIdentity.DefaultRoleClaimType);
            if (roleClaim == null)
            {
                return BadRequest();
            }

            var query = new CheckRoleIsModeratorQuery { RoleId = Guid.Parse(roleClaim.Value) };
            var roleIsModerator = await Mediator.Send(query);

            return roleIsModerator;
        }
    }
}
