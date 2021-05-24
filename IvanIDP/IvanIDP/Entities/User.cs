using Microsoft.AspNetCore.Identity;

namespace IvanIDP.Entities
{
    public class User: IdentityUser
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }
}
