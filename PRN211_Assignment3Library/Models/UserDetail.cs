using System;
using System.Collections.Generic;

namespace PRN211_Assignment3Library.Models;

public partial class UserDetail
{
    public int UserDetailId { get; set; }

    public int UserId { get; set; }

    public string? Name { get; set; }

    public DateTime? DateBirth { get; set; }

    public string? Address { get; set; }

    public string? Email { get; set; }

    public string? Phone { get; set; }

    public virtual User User { get; set; } = null!;
}
