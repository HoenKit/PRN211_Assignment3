using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using PRN211_Assignment3Library.Models;

namespace PRN211_Assignment3Web.Controllers
{
    public class OrdersController : Controller
    {
        private readonly Prn211Assignment3Context _context;

        public OrdersController(Prn211Assignment3Context context)
        {
            _context = context;
        }

        // GET: Orders
        public async Task<IActionResult> Index()
        {
            var prn211Assignment3Context = _context.Orders.Include(o => o.User);
            return View(await prn211Assignment3Context.ToListAsync());
        }

        // GET: Orders/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Orders == null)
            {
                return NotFound();
            }

            var order = await _context.Orders
                .Include(o => o.User)
                .FirstOrDefaultAsync(m => m.OrderId == id);
            if (order == null)
            {
                return NotFound();
            }

            return View(order);
        }

        // GET: Orders/Create
        public async Task<IActionResult> Create([Bind("OrderId")] Order order, int unitStock, int productId, decimal unitPrice)
        {
            if (ModelState.IsValid)
            {
                // Lấy UserId từ session
                int? userId = HttpContext.Session.GetInt32("UserId");
                if (userId.HasValue)
                {
                    order.UserId = userId.Value;
                    order.OrderDate = DateTime.Now;
                    order.Status = 0;
                    decimal totalPrice = unitStock * unitPrice;

                    _context.Add(order);
                    await _context.SaveChangesAsync();
                    int orderId = order.OrderId;
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.OrderId = orderId;
                    orderDetail.ProductId = productId;
                    orderDetail.UnitPrice = totalPrice;
                    orderDetail.UnitStock = unitStock;
                    _context.Add(orderDetail);
                    await _context.SaveChangesAsync();
                    int orderDetailId = orderDetail.OrderDetailId;
                    return RedirectToAction("Details", "OrderDetails", new { id = orderDetailId });
                }
                else
                {
                    return RedirectToAction("Login", "Users");
                }
            }
            return RedirectToAction("Details", "Home");
        }

        // GET: Orders/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Orders == null)
            {
                return NotFound();
            }

            var order = await _context.Orders.FindAsync(id);
            if (order == null)
            {
                return NotFound();
            }
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", order.UserId);
            return View(order);
        }

        // POST: Orders/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("OrderId,OrderDate,UserId,Status")] Order order)
        {
            if (id != order.OrderId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(order);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!OrderExists(order.OrderId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", order.UserId);
            return View(order);
        }

        // GET: Orders/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Orders == null)
            {
                return NotFound();
            }

            var order = await _context.Orders
                .Include(o => o.User)
                .FirstOrDefaultAsync(m => m.OrderId == id);
            if (order == null)
            {
                return NotFound();
            }

            return View(order);
        }

        // POST: Orders/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Orders == null)
            {
                return Problem("Entity set 'Prn211Assignment3Context.Orders'  is null.");
            }
            var order = await _context.Orders.FindAsync(id);
            if (order != null)
            {
                _context.Orders.Remove(order);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool OrderExists(int id)
        {
          return (_context.Orders?.Any(e => e.OrderId == id)).GetValueOrDefault();
        }
    }
}
