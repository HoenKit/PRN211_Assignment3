using System;
using System.Collections.Generic;

namespace PRN211_Assignment3Library.Models;

public partial class Product
{
    public int ProductId { get; set; }

    public string? ProductName { get; set; }

    public int? CategoryId { get; set; }

    public int? UnitStock { get; set; }

    public decimal? UnitPrice { get; set; }

    public DateTime? Date { get; set; }

    public string? Images { get; set; }

    public int? Status { get; set; }

    public int? UserId { get; set; }

    public virtual Category? Category { get; set; }

    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    public virtual User? User { get; set; }
}
