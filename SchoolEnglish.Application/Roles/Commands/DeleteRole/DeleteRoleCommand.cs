using MediatR;
using Microsoft.EntityFrameworkCore;
using SchoolEnglish.Application.Interfaces;
using SchoolEnglish.Application.Common.Exceptions;

namespace SchoolEnglish.Application.Roles.Commands.DeleteRole
{
    public class DeleteRoleCommand : IRequest
    {
        public Guid Id { get; set; }
    }
}
