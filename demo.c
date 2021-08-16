#include <stdio.h>
#include <stdlib.h>
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

static int foo(lua_State *L)
{
    int n = lua_gettop(L);    /* number of arguments */
    lua_Number sum = 0;

    for (int i = 1; i <= n; i++)
    {
        if (!lua_isnumber(L, i))
        {
            lua_pushstring(L, "incorrect argument");
            lua_error(L);
        }
        sum += lua_tonumber(L, i);
    }
    lua_pushnumber(L, sum/n);        /* first result */
    lua_pushnumber(L, sum);         /* second result */
    return 2;                   /* number of results */
}

static int bar(lua_State *L, int number)
{
    // Push the fib function on the top of the lua stack
    lua_getglobal(L, "square");

    // Push the argument (the number 13) on the stack 
    lua_pushnumber(L, number);

    // call the function with 1 argument, returning a single result.  Note that the function actually
    // returns 2 results -- we just want one of them.  The second result will *not* be pushed on the
    // lua stack, so we don't need to clean up after it
    lua_call(L, 1, 1);

    // Get the result from the lua stack
    int result = (int)lua_tointeger(L, -1);

    // Clean up.  If we don't do this last step, we'll leak stack memory.
    lua_pop(L, 1);

    return result;
}

int main(void)
{
    lua_State *L = luaL_newstate(); // open Lua

    if (L == NULL)
    {
        fprintf(stderr, "luaL_newstate() returned NULL");
        exit(EXIT_FAILURE);
    }

    luaL_openlibs(L); // load Lua libraries

    lua_register(L, "foo", foo);
    /* same than
    lua_pushcfunction(L, foo);
    lua_setglobal(L, "foo");
    */

    if (luaL_dofile(L, "demo.lua") != 0)
    {
        fprintf(stderr, "%s\n", lua_tostring(L, -1)); // tell us what mistake we made
        return 1;
    }

    printf("square(7) = %d\n", bar(L, 7));

    lua_close(L); // Close Lua
    return 0;
}

