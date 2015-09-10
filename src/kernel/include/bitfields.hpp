#pragma once
/**
 * @file      bitfields.hpp
 * @brief     Some utilities for bitfields manipulation
 * @author    Loïc Payol
 * @date      Sept. 10, 2015
 */


/**
 * Returns the `y`th bit of `x`
 *
 * @param The bitmsk to extract the bit from
 * @param The index of the bit to extract
 */
#define MASK_GET_BIT(x, y) (!!((x) >> (y)))


/**
 * Turns the `y`th bit of `x` on. Does not changes the bitfield
 *
 * @param x The bitfield to work on
 * @param y The bit to turn on (index starting at 0)
 * 
 */
#define MASK_SET_BIT_ON(x, y) ((x) | (1 << (y)))

/**
 * Turns the `y`th bit of `x` off. Does not changes the bitfield
 *
 * @param x The bitfield to work on
 * @param y The bit to turn off (index starting at 0)
 */
#define MASK_SET_BIT_OFF(x, y) ((x) & (~(1 << (y))))

/**
 * Takes the `y` first bits of `x`
 *
 * @param x The bitfield to work on
 * @param y The number of bits to take
 */
#define MASK_GET_FIRST(x, y) ((x) & (~(-1 << (y))))

/**
 * Takes the bits from the `srt`th to the `end`th ones.
 *
 * @param x The bitfield to work on
 * @param srt The index of the bit from where to start extracting bits, included
 * @param end The index of the bit from where to stop extracting bits, excluded
 */
#define MASK_GET_FROM_TO(x, srt, end) MASK_GET_FIRST((x) >> (srt), (end) - (srt))

/**
 * Changes the bits from the `srt`th to the `end`th ones according to `val`.
 *
 * @param x The bitfield to work on
 * @param val The value to set between `srt` and `end`
 * @param srt The index of the bit from where to start extracting bits, included
 * @param end The index of the bit from where to stop extracting bits, excluded
 */
#define MASK_SET_FROM_TO(x, val, srt, end) (((x) & (-1 << (srt))) | \
    (MASK_GET_FIRST((val), (end) - (srt)) << (srt)))
