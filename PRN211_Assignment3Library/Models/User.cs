using System;
using System.Collections.Generic;

namespace PRN211_Assignment3Library.Models;

public partial class User
{
    public int UserId { get; set; }

    public int? RoleId { get; set; }

    public string? UserName { get; set; }

    public string? Password { get; set; }

    public int? Status { get; set; }

    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    public virtual ICollection<Product> Products { get; set; } = new List<Product>();

    public virtual UserRole? Role { get; set; }

    public virtual ICollection<UserDetail> UserDetails { get; set; } = new List<UserDetail>();
}
