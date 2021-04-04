#ifndef DEBUG_H
#define DEBUG_H

void noop() {}

#ifdef DEBUG_TRACE
	#define DEBUG_MSG_TRACE(msg, ...) Print(L"[Bootloader] "); \
		Print(msg, ##__VA_ARGS__); \
		Print(L"\n\r")
#else
	#define DEBUG_MSG_TRACE(msg, ...) noop()
#endif

#ifdef DEBUG_ERROR
	#define DEBUG_MSG_ERROR(msg, ...) Print(L"[Bootloader] "); \
		Print(msg, ##__VA_ARGS__); \
		Print(L"\n\r")
#else
	#define DEBUG_MSG_ERROR(msg, ...) noop()
#endif

#endif
