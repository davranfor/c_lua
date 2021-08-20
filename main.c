#include <stdio.h>
#include <stdlib.h>
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

// C callable functions
static int avg_and_sum(lua_State *L)
{
    int n = lua_gettop(L); // number of arguments
    lua_Number sum = 0;

    for (int i = 1; i <= n; i++)
    {
        if (!lua_isnumber(L, i))
        {
            lua_pushliteral(L, "incorrect argument");
            lua_error(L);
        }
        sum += lua_tonumber(L, i);
    }
    lua_pushnumber(L, sum / n); // first result
    lua_pushnumber(L, sum);     // second result
    return 2;                   // number of results
}

// Lua callable functions
static double square(lua_State *L, lua_Number num)
{
    // push the square function on the top of the lua stack
    lua_getglobal(L, "square");
    // push the argument (the number) on the stack 
    lua_pushnumber(L, num);
    // call the function with 1 argument, returning a single result.
    lua_call(L, 1, 1);

    // get the result from the lua stack
    double result = lua_tonumber(L, -1);

    // clean up. If we don't do this last step, we'll leak stack memory.
    lua_pop(L, 1);
    return result;
}

static void capitalize(lua_State *L, const char *str)
{
    lua_getglobal(L, "capitalize");
    lua_pushstring(L, str);
    lua_call(L, 1, 1);
    printf("capitalize(%s) = %s\n", str, lua_tostring(L, -1));
    lua_pop(L, 1);
}

int main(void)
{
    lua_State *L = luaL_newstate(); // open Lua

    if (L == NULL)
    {
        fprintf(stderr, "error: luaL_newstate\n");
        exit(EXIT_FAILURE);
    }
    luaL_openlibs(L); // load Lua libraries
    lua_register(L, "avg_and_sum", avg_and_sum);
    if (luaL_dofile(L, "main.lua") != 0)
    {
        // tell us what mistake we made
        fprintf(stderr, "%s\n", lua_tostring(L, -1));
        return 1;
    }
    printf("square(7) = %.0f\n", square(L, 7));
    capitalize(L, "world");
    lua_close(L); // close Lua
    return 0;
}

