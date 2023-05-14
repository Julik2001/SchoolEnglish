using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SchoolEnglish.Application.Reports.Queries.GetReportForStudent;
using SchoolEnglish.Application.Tasks.Queries.GetTask;
using SchoolEnglish.Application.Users.Commands.UpdateBalance;
using SchoolEnglish.Application.UserTaskRewards.Commands.CreateUserTaskReward;
using SchoolEnglish.Application.UserTaskRewards.Queries.CheckUserTaskReward;
using System.Security.Claims;

namespace SchoolEnglish.WebApi.Controllers
{
    [ApiController]
    public class ReportController : BaseController
    {
        [Authorize]
        [HttpGet("{taskId}")]
        public async Task<ActionResult<StudentReportVm>> GetTaskReport(Guid taskId)
        {
            var userIdClaim = User.Claims.FirstOrDefault(claim => claim.Type == ClaimsIdentity.DefaultNameClaimType);
            if (userIdClaim == null)
            {
                return BadRequest();
            }
            var userId = Guid.Parse(userIdClaim.Value);

            var query = new GetReportForStudentQuery { TaskId = taskId, UserId = userId };
            var vm = await Mediator.Send(query);

            var checkRewardQuery = new CheckUserTaskRewardQuery { TaskId = taskId, UserId = userId };
            var rewardPaid = await Mediator.Send(checkRewardQuery);

            if (vm.Grade >= 3 && !rewardPaid)
            {
                var taskQuery = new GetTaskQuery { Id = taskId };
                var task = await Mediator.Send(taskQuery);
                vm.Reward = task.Reward;

                var balanceCommand = new UpdateBalanceCommand 
                {
                    UserId = userId,
                    BalanceDifference = task.Reward,
                    ToAdd = true,
                    ToRemove = false
                };
                await Mediator.Send(balanceCommand);

                var rewardCommand = new CreateUserTaskRewardCommand { TaskId = taskId, UserId = userId };
                await Mediator.Send(rewardCommand);
            }
            else
            {
                vm.Reward = 0;
            }

            return Ok(vm);
        }
    }
}
