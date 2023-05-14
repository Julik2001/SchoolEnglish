using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SchoolEnglish.Application.UserTaskRewards.Commands.CreateUserTaskReward;
using System.Security.Claims;

namespace SchoolEnglish.WebApi.Controllers
{
    [ApiController]
    public class UserTaskRewardController : BaseController
    {
        [Authorize]
        [HttpPost("{taskId}")]
        public async Task<ActionResult<Guid>> Create(Guid taskId)
        {
            var userIdClaim = User.Claims.FirstOrDefault(claim => claim.Type == ClaimsIdentity.DefaultNameClaimType);
            if (userIdClaim == null)
            {
                return BadRequest();
            }
            
            var command = new CreateUserTaskRewardCommand { UserId = Guid.Parse(userIdClaim.Value), TaskId = taskId };
            var rewardId = await Mediator.Send(command);

            return Ok(rewardId);
        }
    }
}
