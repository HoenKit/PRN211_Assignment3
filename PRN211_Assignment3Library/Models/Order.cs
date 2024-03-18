using System;
using System.Collections.Generic;

namespace PRN211_Assignment3Library.Models;

public partial class Order
{
    public int OrderId { get; set; }

    public DateTime? OrderDate { get; set; }

    public int? UserId { get; set; }

    public int? Status { get; set; }

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public virtual User? User { get; set; }
}
