using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using PRN211_Assignment3Library.Models;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace PRN211_Assignment3Web.Controllers
{
    public class UserDetailsController : BaseController
    {
        private readonly Prn211Assignment3Context _context;

        public UserDetailsController(Prn211Assignment3Context context)
        {
            _context = context;
        }

        // GET: UserDetails
        public async Task<IActionResult> Index(string? name)
        {
            var prn211Assignment3Context = await _context.UserDetails.Include(u => u.User).ToListAsync();
            if (name != null)
            {
                return View(prn211Assignment3Context.Where(p => p.Name
                    .Contains(name, StringComparison.OrdinalIgnoreCase)));
            }
            return View(prn211Assignment3Context);
        }

        // GET: UserDetails/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.UserDetails == null)
            {
                return NotFound();
            }

            var userDetail = await _context.UserDetails
                .Include(u => u.User.Role)
                .FirstOrDefaultAsync(m => m.UserDetailId == id);
            if (userDetail == null)
            {
                return NotFound();
            }

            return View(userDetail);
        }

        // GET: UserDetails/Create
        public IActionResult Create(int userId)
        {
            if (userId <= 0)
            {
                return BadRequest();
            }
            UserDetail userDetail = new UserDetail
            {
                UserId = userId,
            };
            return View(userDetail);
        }

        // POST: UserDetails/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("UserDetailId,UserId,Name,DateBirth,Address,Email,Phone")] UserDetail userDetail)
        {
            if (ModelState.IsValid)
            {
                _context.Add(userDetail);
                await _context.SaveChangesAsync();
                return RedirectToAction("Login", "Users");
            }
            return View(userDetail);
        }

        // GET: UserDetails/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.UserDetails == null)
            {
                return NotFound();
            }

            var userDetail = await _context.UserDetails.FindAsync(id);
            if (userDetail == null)
            {
                return NotFound();
            }
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", userDetail.UserId);
            return View(userDetail);
        }

        // POST: UserDetails/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("UserDetailId,UserId,Name,DateBirth,Address,Email,Phone")] UserDetail userDetail)
        {
            if (id != userDetail.UserDetailId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(userDetail);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!UserDetailExists(userDetail.UserDetailId))
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
            ViewData["UserId"] = new SelectList(_context.Users, "UserId", "UserId", userDetail.UserId);
            return View(userDetail);
        }

        // GET: UserDetails/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.UserDetails == null)
            {
                return NotFound();
            }

            var userDetail = await _context.UserDetails
                .Include(u => u.User)
                .FirstOrDefaultAsync(m => m.UserDetailId == id);
            if (userDetail == null)
            {
                return NotFound();
            }

            return View(userDetail);
        }

        // POST: UserDetails/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.UserDetails == null)
            {
                return Problem("Entity set 'Prn211Assignment3Context.UserDetails'  is null.");
            }
            var userDetail = await _context.UserDetails.FindAsync(id);
            if (userDetail != null)
            {
                _context.UserDetails.Remove(userDetail);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool UserDetailExists(int id)
        {
          return (_context.UserDetails?.Any(e => e.UserDetailId == id)).GetValueOrDefault();
        }

        //View user profile
        public async Task<IActionResult> Profile()
        {
            int? userId = HttpContext.Session.GetInt32("UserId");
            if (userId == null)
            {
                return RedirectToAction("Login", "Users");
            }

            var userDetail = await _context.UserDetails
            .Include(u => u.User)
            .ThenInclude(u => u.Role)
            .FirstOrDefaultAsync(u => u.UserId == userId);

            if (userDetail == null)
            {
                return NotFound();
            }

            return View(userDetail);
        }
        // GET: UserDetails/EditProfile
        public async Task<IActionResult> EditProfile()
        {
            int? userId = HttpContext.Session.GetInt32("UserId");
            if (userId == null)
            {
                return RedirectToAction("Login", "Users");
            }

            var userDetail = await _context.UserDetails
                .Include(u => u.User)
                .ThenInclude(u => u.Role)
                .FirstOrDefaultAsync(u => u.UserId == userId);

            if (userDetail == null)
            {
                return NotFound();
            }

            return View(userDetail);
        }
        // POST: UserDetails/EditProfile
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditProfile([Bind("UserDetailId,UserId,Name,DateBirth,Address,Email,Phone")] UserDetail userDetail)
        {
            int? userId = HttpContext.Session.GetInt32("UserId");
            if (userId == null || userId != userDetail.UserId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(userDetail);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!UserDetailExists(userDetail.UserDetailId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Profile));
            }
            return View(userDetail);
        }
    }
}
