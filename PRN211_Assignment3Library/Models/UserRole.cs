using System;
using System.Collections.Generic;

namespace PRN211_Assignment3Library.Models;

public partial class UserRole
{
    public int RoleId { get; set; }

    public string? Name { get; set; }

    public int? Status { get; set; }

    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
